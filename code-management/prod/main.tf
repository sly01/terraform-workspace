module "anything" {
  source            = "../asg-module"
  delegation_set    = "N2MKEHLV1FV47O"
  dns_zone_creation = false
  domain_name       = "aerkoc"
  environment       = "prod"
  instance_type     = "t2.small"
  max_size          = 5
  region            = "eu-west-1"
  web_port          = "8888"
}
