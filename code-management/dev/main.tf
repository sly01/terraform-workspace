terraform {
  backend "s3" {
    bucket = "terraform-atos-state"
    key    = "state-files/something.tfstate"
    region = "eu-central-1"
  }
}



module "anything" {
  source            = "git::https://github.com/sly01/asg-module.git?ref=v0.0.2"
  delegation_set    = "N2MKEHLV1FV47O"
  dns_zone_creation = true
  domain_name       = "aerkoc"
  environment       = "dev"
  instance_type     = "t2.micro"
  max_size          = 5
  region            = "eu-central-1"
  web_port          = "8888"
}
