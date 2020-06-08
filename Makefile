CLUSTER_NAME := $(shell whoami)-testcluster

VARS := -var 'agent_cidr_range=10.0.0.0/16' -var 'master_cidr_range=10.1.0.0/16' -var 'cluster_name=$(CLUSTER_NAME)'

.PHONY: init
init:
	terraform init

.PHONY: fmt
fmt:
	terraform fmt

.PHONY: validate
validate:
	terraform validate

.PHONY: plan
plan: fmt validate init
	terraform plan ${VARS}

.PHONY: test
test: fmt
	go test ./test -timeout 1h -v
