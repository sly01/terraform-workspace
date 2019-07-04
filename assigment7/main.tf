provider "aws" {
  region = "us-east-1"
}

#Deploy networking
module "networking" {
  source               = "git::https://github.com/sly01/terraform-workshop-modules//network?ref=v0.0.1"
  cidr_block           = "${var.cidr_block}"
  private_subnet_count = "${var.private_subnet_count}"
  private_cidrs        = "${var.private_cidrs}"
  public_subnet_count  = "${var.public_subnet_count}"
  public_cidrs         = "${var.public_cidrs}"
}

#Deploy compute
module "computing" {
  source                  = "git::https://github.com/sly01/terraform-workshop-modules//compute?ref=v0.0.1"
  instance-count          = "${var.instance-count}"
  elb_healthy_threshold   = "${var.elb_healthy_threshold}"
  elb_unhealthy_threshold = "${var.elb_unhealthy_threshold}"
  public_subnets          = "${module.networking.public_subnets}"
  private_subnets         = "${module.networking.private_subnets}"
  elb-sg                  = "${module.networking.elb-sg}"
  instance-sg             = "${module.networking.elb-to-ec2}"
  public_key              = "${var.public_key}"
  ansible-management-sg   = "${module.networking.ansible-management-sg}"
}
