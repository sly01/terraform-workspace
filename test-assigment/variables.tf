variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "public_subnets" {
  type = "list"
  default = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
}
