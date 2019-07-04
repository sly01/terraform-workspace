terraform {
  backend "s3" {}
}

#terraform {
#  backend "s3" {
#    bucket = "la-terraform-erkoca-state"
#    key = "terraform/terraform.tfstate"
#    region = "us-west-2"
#    shared_credentials_file = "./credentials"
#  }
#}

provider "aws" {
  region = "${var.region}"
}

#Deploy networking
module "networking" {
  source               = "git::https://github.com/sly01/terraform-workshop-modules//network?ref=v0.0.3"
  cidr_block           = "${var.cidr_block}"
  private_subnet_count = "${var.private_subnet_count}"
  private_cidrs        = "${var.private_cidrs}"
  public_subnet_count  = "${var.public_subnet_count}"
  public_cidrs         = "${var.public_cidrs}"
}
