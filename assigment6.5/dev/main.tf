provider "aws" {
  region = "${var.region}"
}

module "infra" {
  source = "git::https://github.com/sly01/terraform-workshop-modules//module-test?ref=v0.0.2"
  env    = "${var.env}"
}
