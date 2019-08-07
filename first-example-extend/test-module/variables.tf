variable "region" {
  description = "AWS Region(us-east-1, eu-central-1 ...)"
}
variable "instance_type" {
  description = "Flavor(t2.micro ...)"
}

variable "environment" {
  description = "Environment(dev, prod, nonprod)"
}

variable "max_size" {
  description = "Number of max instance for asg"
}
variable "min_size" {
  description = "Number of min instance for asg"
  default     = 2
}

variable "web_port" {
  description = "Web access port for instances"
}

variable "domain_name" {
  description = "Domain name which is given by tk"
}

variable "delegation_set" {
  description = "Route53 delegation set"
}

variable "dns_zone_creation" {
  description = "Dns zone creation(true/false)"
  type        = "bool"
}
