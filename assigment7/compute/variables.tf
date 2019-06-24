variable "public_subnets" {
  type = "list"
}

variable "elb-sg" {}

variable "instance-sg" {}

variable "instance-count" {}

variable "private_subnets" {
  type = "list"
}
