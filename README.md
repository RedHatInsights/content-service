# Insights Content Service

[![forthebadge made-with-go](https://img.shields.io/badge/Made%20with-Go-1f425f.svg)](https://go.dev/)
[![License](https://img.shields.io/badge/license-Apache-blue)](https://redhat.com/content-service/-/blob/master/LICENSE)

Content service for Insights rules groups, tags, and content.

<!-- vim-markdown-toc GFM -->

- [Insights Content Service](#insights-content-service)
  - [Description](#description)
  - [Documentation](#documentation)
  - [Usage](#usage)
  - [Makefile targets](#makefile-targets)
  - [BDD tests](#bdd-tests)
  - [Definition of Done for new features and fixes](#definition-of-done-for-new-features-and-fixes)
  - [Contribution](#contribution)

<!-- vim-markdown-toc -->


## Description

Insights Content Service is a service that provides metadata information about rules that are being
consumed by Openshift Cluster Manager. That metadata information contains rule title, description,
remmediations, tags and also groups, that will be consumed primarily by
[Insights Results Smart Proxy](https://github.com/RedHatInsights/insights-results-smart-proxy).

## Documentation

Documentation is hosted on CEE Gitlab Pages <https://ccx.pages.redhat.com/content-service/>.
Sources are located in [docs](https://redhat.com/content-service/-/tree/master/docs?ref_type=heads).

## Usage

```
Usage:

    ./insights-content-service [command]

The commands are:

    <EMPTY>             starts content service
    start-service       starts content service
    help                prints help
    print-help          prints help
    print-config        prints current configuration set by files & env variables
    print-groups        prints current groups configuration
    print-rules         prints current parsed rules
    print-parse-status  prints information about all rules that have been parsed
    print-version-info  prints version info

```

## Makefile targets

```
clean                Run go clean
build                Build binary containing service executable
build-cover          Build binary with code coverage detection support
fmt                  Run go fmt -w for all sources
lint                 Run golint
vet                  Run go vet. Report likely mistakes in source code
cyclo                Run gocyclo
ineffassign          Run ineffassign checker
shellcheck           Run shellcheck
errcheck             Run errcheck
goconst              Run goconst checker
gosec                Run gosec checker
abcgo                Run ABC metrics checker
json-check           Check all JSONs for basic syntax
style                Run all the formatting related commands (fmt, vet, lint, cyclo) + check shell scripts
run                  Build the project and executes the binary
test                 Run the unit tests
cover                Generate HTML pages with code coverage
coverage             Display code coverage on terminal
integration_tests    Run all integration tests
help                 Show this help screen
function_list        List all functions in generated binary file
```

## BDD tests

Behaviour tests for this service are included in [Insights Behavioral
Spec](https://github.com/RedHatInsights/insights-behavioral-spec) repository.
In order to run these tests, the following steps need to be made:

1. Build this service using `./build.sh --test-rules-only`
1. clone the [Insights Behavioral Spec](https://github.com/RedHatInsights/insights-behavioral-spec) repository
1. copy this directory with the `insights-content-service` executable into the `insights-behavioral-spec` subdirectory
1. run the `insights_content_service_test.sh` from the `insights-behavioral-spec` subdirectory

List of all test scenarios prepared for this service is available at
<https://redhatinsights.github.io/insights-behavioral-spec/feature_list.html#insights-content-service>


## Definition of Done for new features and fixes

Please look at [DoD.md](DoD.md) document for definition of done for new features and fixes.



## Contribution

Please look into document [CONTRIBUTING.md](CONTRIBUTING.md) that contains all information about how to
contribute to this project.
