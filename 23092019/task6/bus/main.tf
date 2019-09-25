terraform {
  backend "s3" {
    bucket = "whateverinatos"
    key    = "states/mystatefile"
    region = "eu-central-1"
  }
}



module "whatever" {
  source            = "git::https://github.com/sly01/something_remote.git//?ref=v0.0.2"
  delegation_set    = "N32P32CRELXB9T"
  dns_zone_creation = false
  domain_name       = "whateverinatos"
  env               = "bus"
  max_size          = 9
  region            = "us-east-2"
  web_port          = "9999"
}
