#---network-----
variable "cidr_block" {
}

variable "private_subnet_count" {
}

variable "private_cidrs" {
  type = "list"
}

variable "public_subnet_count" {
}
variable "public_cidrs" {
  type = "list"
}

#----compute-----

variable "instance-count" {
  
}