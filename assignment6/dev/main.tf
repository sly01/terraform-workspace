provider "aws" {
  region = "${var.region}"
}

module "infra" {
  source = "../module-test"
  env    = "${var.env}"
}
