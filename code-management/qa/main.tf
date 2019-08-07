module "anything" {
  source            = "../asg-module"
  delegation_set    = "N2MKEHLV1FV47O"
  dns_zone_creation = true
  domain_name       = "aerkoc"
  environment       = "qa"
  instance_type     = "t2.micro"
  max_size          = 5
  region            = "eu-central-1"
  web_port          = "8888"
}
