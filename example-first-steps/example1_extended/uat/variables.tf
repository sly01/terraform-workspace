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

variable "domain_name" {
  description = "Domain name like: aerkoc, merkoc"
}

variable "delegation_set" {
  description = "Delegation set for keeping exact ns for route53"
}

variable "dns_zone_creation" {

}
variable "anything" {

}
