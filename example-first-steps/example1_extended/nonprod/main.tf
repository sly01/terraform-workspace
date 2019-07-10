provider "aws" {
  region = "${var.region}"
}

module "barfoo" {
  source            = "git::https://github.com/sly01/module-atos.git?ref=v0.0.2"
  dns_zone_creation = "${var.dns_zone_creation}"
  delegation_set    = "${var.delegation_set}"
  domain_name       = "${var.domain_name}"
  environment       = "${var.environment}"
  instance_count    = "${var.instance_count}"
  region            = "${var.region}"
  sg_description    = "${var.sg_description}"
  web_port          = "${var.web_port}"
}
