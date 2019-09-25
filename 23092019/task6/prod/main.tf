module "whatever" {
  source            = "../something"
  delegation_set    = "N32P32CRELXB9T"
  dns_zone_creation = true
  domain_name       = "whateverinatos"
  env               = "prod"
  max_size          = 3
  region            = "eu-central-1"
  web_port          = "9999"
}
