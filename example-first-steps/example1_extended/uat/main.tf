provider "aws" {
  region = "${var.region}"
}

module "foobar" {
  source            = "../module-atos"
  region            = "${var.region}"
  sg_description    = "${var.sg_description}"
  web_port          = "${var.web_port}"
  domain_name       = "${var.domain_name}"
  delegation_set    = "${var.delegation_set}"
  dns_zone_creation = "${var.dns_zone_creation}"
  environment       = "${var.anything}"
}
