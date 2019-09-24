variable "region" {
  description = "Region eu-central-1, us-east-1"
}

variable "env" {
  description = "Environment such as dev, prod, nonprod, stage"
}
variable "instance_type" {
  description = "Flavor of machine t2.micro, t2.small, etc..."
  default     = "t2.micro"
}

variable "web_port" {
  description = "Web port 8080, 80, 9090"
}

variable "max_size" {
  description = "Max size for ASG"
}

variable "min_size" {
  description = "Min size for ASG"
  default     = 2
}
