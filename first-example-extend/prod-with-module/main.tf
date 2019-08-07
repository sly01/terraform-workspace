module "foobar" {
  source            = "../test-module"
  region            = "${var.region}"
  instance_type     = "${var.instance_type}"
  environment       = "${var.environment}"
  max_size          = "${var.max_size}"
  min_size          = "${var.min_size}"
  web_port          = "${var.web_port}"
  domain_name       = "${var.domain_name}"
  delegation_set    = "${var.delegation_set}"
  dns_zone_creation = "${var.dns_zone_creation}"
}
