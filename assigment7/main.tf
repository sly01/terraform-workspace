provider "aws" {
  region = "us-east-1"
}

#Deploy networking
module "networking" {
  source               = "./network"
  cidr_block           = "${var.cidr_block}"
  private_subnet_count = "${var.private_subnet_count}"
  private_cidrs        = "${var.private_cidrs}"
  public_subnet_count  = "${var.public_subnet_count}"
  public_cidrs         = "${var.public_cidrs}"
}

#Deploy compute
module "computing" {
  source          = "./compute"
  instance-count  = "${var.instance-count}"
  public_subnets  = "${module.networking.public_subnets}"
  private_subnets = "${module.networking.private_subnets}"
  elb-sg          = "${module.networking.elb-sg}"
  instance-sg     = "${module.networking.elb-to-ec2}"
}
