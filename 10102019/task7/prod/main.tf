module "something" {
  source            = "git::https://github.com/sly01/dupadupa.git?ref=v0.0.2"
  delegation_set    = "N2MUOAJ7R9AZD9"
  dns_zone_creation = true
  domain_name       = "aerkocatos"
  env               = "prod"
  instance_type     = "t2.micro"
  max_size          = 5
  min_size          = 3
  region            = "eu-central-1"
  web_port          = 9999
}
