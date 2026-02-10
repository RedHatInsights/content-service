# Copyright 2020 Red Hat, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM registry.access.redhat.com/ubi9/go-toolset:latest AS builder

COPY . .

USER 0

# clone rules content repository and build the content service
RUN umask 0022 && \
    git config --global --add safe.directory /opt/app-root/src && \
    make build && \
    chmod a+x content-service

FROM quay.io/redhat-services-prod/obsint-processing-tenant/rules-containers/rules-containers-private:2026.02.10.post1 AS rules-source

FROM registry.access.redhat.com/ubi9/ubi-micro:latest

COPY --from=builder /opt/app-root/src/content-service .
COPY --from=builder /opt/app-root/src/openapi.json /openapi/openapi.json
COPY --from=builder /opt/app-root/src/groups_config.yaml /groups/groups_config.yaml

# copy the certificates from builder image
COPY --from=builder /etc/ssl /etc/ssl
COPY --from=builder /etc/pki /etc/pki

# copy just the rule content instead of the whole ocp-rules repository
COPY --from=rules-source /app/content/content /rules-content

USER 1001

CMD ["/content-service"]
