help:
	@echo "init: Initialize terraform"
	@echo "plan: Plan terraform"
	@echo "apply: Apply terraform"
	@echo "destroy: Destroy terraform"

all: apply

init:
	terraform -chdir=terraform/ init

plan: init check-env
	terraform -chdir=terraform/ plan

apply: init plan
	terraform -chdir=terraform/ apply -auto-approve

destroy: plan
	terraform -chdir=terraform/ destroy -auto-approve

check-env:
ifndef TF_VAR_r2_access
	$(error R2 Access key is missing. Define TF_VAR_r2_access variable.)
endif

ifndef TF_VAR_r2_secret
	$(error R2 Secret key is missing. Define TF_VAR_r2_secret variable.)
endif

ifndef TF_VAR_r2_account_id
	$(error R2 Account ID is missing. Define TF_VAR_r2_account_id variable.)
endif
