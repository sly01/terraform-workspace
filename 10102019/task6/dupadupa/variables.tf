variable "region" {
  type = "string"
}

variable "web_port" {
  default = 8080
}

variable "instance_type" {
  type        = "string"
  description = "Flavor -> t2.micro, t2.small"
  default     = "t2.micro"
}

variable "env" {
  type        = "string"
  description = "environment"
}

variable "min_size" {
  description = "Min number of instances"
  default     = 2
}

variable "max_size" {
  description = "Max number of instances"
}

variable "domain_name" {
  type        = "string"
  description = "Domain name"
}

variable "delegation_set" {
  type        = "string"
  description = "Delegation set for Route53"
}

variable "dns_zone_creation" {
  description = "Dns zone creation decision"
}
