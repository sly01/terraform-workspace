#---network-----
variable "cidr_block" {}

variable "private_subnet_count" {}

variable "private_cidrs" {
  type = "list"
}

variable "public_subnet_count" {}

variable "public_cidrs" {
  type = "list"
}

#----compute-----

variable "instance-count" {}

variable "elb_healthy_threshold" {}

variable "elb_unhealthy_threshold" {}

variable "public_key" {}
