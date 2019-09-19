variable "region" {
  type        = "string"
  description = "Region of aws eu-central-1,us-east-1"
  default     = "eu-central-1"
}

variable "instance_size" {
  description = "Flavor t2.micro, t2.small"
}

variable "web_port" {
  description = "web port 79,8080,9999,1111"
}

variable "env" {
  type        = "string"
  description = "Environment dev,prod,nonprod whatever...."
}

variable "instance_count" {
  description = "Number of instances"
}

variable "max_size" {
  description = "max size for asg"
}

variable "min_size" {
  description = "min size for asg"
}

variable "domain_name" {
  description = "domain name end with tk"
}

variable "delegation_set" {
  description = "delegation set for route53"
}

variable "dns_zone_creation" {
  description = "Create dns zone or use existing"
}
