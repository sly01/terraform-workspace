module "whatever" {
  source            = "git::https://github.com/sly01/something_remote.git//?ref=v0.0.1"
  delegation_set    = "N32P32CRELXB9T"
  dns_zone_creation = false
  domain_name       = "whateverinatos"
  env               = "nonprod"
  max_size          = 3
  region            = "eu-west-1"
  web_port          = "9999"
}
