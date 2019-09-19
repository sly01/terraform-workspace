terraform {
  backend "s3" {
    bucket = "atos-terra"
    key    = "states/compute"
    region = "eu-central-1"
  }
}

module "something" {
  source            = "git::https://github.com/sly01/module1.git//?ref=v0.0.2"
  delegation_set    = "N15TUCL1YYDVU0"
  dns_zone_creation = true
  domain_name       = "atospl"
  env               = "dev"
  instance_size     = "t2.micro"
  max_size          = 4
  min_size          = 2
  region            = "eu-central-1"
  web_port          = "5555"
}
