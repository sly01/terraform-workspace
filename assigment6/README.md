#### Assignment 6

**local module**

1. Dev env
```
cd dev/
terraform init
terraform plan -var-file=../common/common.tfvars
terraform apply -var-file=../common/common.tfvars
terraform destroy -var-file=../common/common.tfvars
```
2. stage env
```
cd stage/
terraform init
terraform plan -var-file=../common/common.tfvars
terraform apply -var-file=../common/common.tfvars
terraform destroy -var-file=../common/common.tfvars
```
