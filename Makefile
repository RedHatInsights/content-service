SHELL := /bin/bash

.PHONY: default clean build fmt lint shellcheck abcgo json-check style run test cover license openapi-check before_commit help godoc install_docgo install_addlicense

SOURCES:=$(shell find . -name '*.go')
BINARY:=insights-content-service
DOCFILES:=$(addprefix docs/packages/, $(addsuffix .html, $(basename ${SOURCES})))

default: build

clean: ## Run go clean
	@go clean
	rm -f rest-api-tests

build: ${BINARY} ## Build binary containing service executable

build-cover:	${SOURCES}  ## Build binary with code coverage detection support
	./build.sh -cover

${BINARY}: ${SOURCES}
	./build.sh

checker/checker: checker/main.go
	cd checker
	go build
	cd ..

install_golangci-lint:
	go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest

fmt: install_golangci-lint ## Run go formatting
	@echo "Running go formatting"
	golangci-lint fmt

lint: install_golangci-lint ## Run go liting
	@echo "Running go linting"
	golangci-lint run --fix

shellcheck: ## Run shellcheck
	@echo "Running shellcheck"
	pre-commit run shellcheck --all-files

abcgo: ## Run ABC metrics checker
	@echo "Run ABC metrics checker"
	pre-commit run abcgo --all-files

json-check: ## Check all JSONs for basic syntax
	@echo "Run JSON checker"
	pre-commit run check-json --all-files

openapi-check:
	./check_openapi.sh

style: fmt lint shellcheck abcgo ## Run all the formatting related commands (fmt, vet, lint, cyclo) + check shell scripts

run: clean build ## Build the project and executes the binary
	./insights-content-service

test: clean build ## Run the unit tests
	@go test -coverprofile coverage.out $(shell go list ./... | grep -v tests)

cover: test ## Generate HTML pages with code coverage
	@go tool cover -html=coverage.out

coverage: ## Display code coverage on terminal
	@go tool cover -func=coverage.out

integration_tests: ## Run all integration tests
	@echo "Running all integration tests"
	@./test.sh

license: install_addlicense
	addlicense -c "Red Hat, Inc" -l "apache" -v ./

before_commit: style test openapi-check license
	./check_coverage.sh

help: ## Show this help screen
	@echo 'Usage: make <OPTIONS> ... <TARGETS>'
	@echo ''
	@echo 'Available targets are:'
	@echo ''
	@grep -E '^[ a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo ''

function_list: ${BINARY} ## List all functions in generated binary file
	go tool objdump ${BINARY} | grep ^TEXT | sed "s/^TEXT\s//g"

docs/packages/%.html: %.go
	mkdir -p $(dir $@)
	docgo -outdir $(dir $@) $^
	addlicense -c "Red Hat, Inc" -l "apache" -v $@

godoc: export GO111MODULE=off
godoc: install_docgo install_addlicense ${DOCFILES} docs/sources.md

docs/sources.md: docs/sources.tmpl.md ${DOCFILES}
	./gen_sources_md.sh

install_docgo: export GO111MODULE=off
install_docgo:
	[[ `command -v docgo` ]] || GO111MODULE=off go get -u github.com/dhconnelly/docgo

install_docgo: export GO111MODULE=off
install_addlicense:
	[[ `command -v addlicense` ]] || GO111MODULE=off go get -u github.com/google/addlicense
