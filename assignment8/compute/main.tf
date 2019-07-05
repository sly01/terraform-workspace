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

#Deploy compute
module "computing" {
  source                  = "git::https://github.com/sly01/terraform-workshop-modules//compute?ref=v0.0.3"
  instance-count          = "${var.instance-count}"
  elb_healthy_threshold   = "${var.elb_healthy_threshold}"
  elb_unhealthy_threshold = "${var.elb_unhealthy_threshold}"
  public_key              = "${var.public_key}"
  public_subnets          = "${data.terraform_remote_state.network.outputs.public_subnets}"
  private_subnets         = "${data.terraform_remote_state.network.outputs.private_subnets}"
  elb-sg                  = "${data.terraform_remote_state.network.outputs.elb-sg}"
  instance-sg             = "${data.terraform_remote_state.network.outputs.elb-to-ec2}"
  ansible-management-sg   = "${data.terraform_remote_state.network.outputs.ansible-management-sg}"
}
