variable "public_subnets" {
  type = "list"
}

variable "elb-sg" {}

variable "instance-sg" {}

variable "ansible-management-sg" {}

variable "instance-count" {}

variable "private_subnets" {
  type = "list"
}

variable "elb_healthy_threshold" {}

variable "elb_unhealthy_threshold" {}

variable "public_key" {}
