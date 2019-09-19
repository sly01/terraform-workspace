module "anything" {
  source            = "../module1"
  delegation_set    = "N15TUCL1YYDVU0"
  dns_zone_creation = false
  domain_name       = "atospl"
  env               = "qa"
  instance_size     = "t2.small"
  max_size          = 6
  min_size          = 3
  region            = "eu-west-2"
  web_port          = "9999"
  instance_count    = 100
}
