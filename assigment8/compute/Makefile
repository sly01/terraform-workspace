.PHONY: all plan apply destroy

all: help

# Add the following 'help' target to your Makefile
# And add help text after each target name starting with '\#\#'

help:						## Show this help
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

get:		verify-aws-profile-set 		## Get the terraform modules
	terraform get

init:		verify-aws-profile-set		## Initialize remote S3 backend.
	terraform init -backend=true -backend-config="bucket=aerkoc-tf-workshop-assignment-8" -backend-config="key=compute.tfstate" -backend-config="region=${AWS_DEFAULT_REGION}"

plan:		verify-aws-profile-set		## Plan the changes to infra.
	terraform plan -var-file=../terraform.tfvars -var-file=./compute.tfvars

refresh:	verify-aws-profile-set		## Refresh the remote state with existing AWS infra.
	terraform refresh -var-file=../terraform.tfvars -var-file=./compute.tfvars

apply:		verify-aws-profile-set		## Apply the changes in plan.
	terraform apply -var-file=../terraform.tfvars -var-file=./compute.tfvars

output:		verify-aws-profile-set		## See the output.
	terraform output -json

destroy:	verify-aws-profile-set		## Destroy the infra. (BE VERY CAREFUL with THIS).
	terraform destroy -var-file=../terraform.tfvars -var-file=./compute.tfvars

#ifndef AWS_PROFILE
#	$(error AWS_PROFILE is not defined. Make sure that you set your AWS profile and region.)
#endif
verify-aws-profile-set:
ifndef AWS_DEFAULT_REGION
	$(error AWS_DEFAULT_REGION is not defined. Make sure that you set your AWS region.)
endif
