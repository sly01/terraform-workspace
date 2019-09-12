module "anything" {
  source            = "../dupadupa"
  delegation_set    = "N2MUOAJ7R9AZD9"
  dns_zone_creation = false
  domain_name       = "aerkocatos"
  env               = "stage"
  instance_type     = "t2.micro"
  max_size          = 6
  min_size          = 4
  region            = "eu-west-1"
  web_port          = 9999
}
