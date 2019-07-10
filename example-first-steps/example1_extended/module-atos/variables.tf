variable "region" {
  description = "Region"
}

variable "sg_description" {
  default = "asdfasdfasd desc"
}
variable "web_port" {
  description = "Your web server port"
}

variable "instance_count" {
  description = "Number of instances"
  default     = 2
}

variable "environment" {
  description = "Environment value"
}

variable "domain_name" {
  description = "Domain name like: aerkoc, merkoc"
}

variable "dns_zone_creation" {
  description = "Dns zone creation true or false"
}

variable "delegation_set" {
  description = "Delegation id for route53 strict nameservers"
}
