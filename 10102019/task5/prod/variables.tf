variable "region" {
  type = string
  #default = "eu-central-1"
}

variable "web_port" {
  type = number
  #default = 8080
}

variable "instance_type" {
  type        = string
  description = "Flavor -> t2.micro, t2.small"
  default     = "t2.micro"
}

variable "env" {
  type        = string
  description = "environment"
}

variable "instance_count" {
  type        = number
  description = "number of instances"
  default     = 2
}
