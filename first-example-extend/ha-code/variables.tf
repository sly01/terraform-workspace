variable "region" {
  description = "Region information"
}

variable "instance_type" {
  description = "Flavor t2.micro, t2.small"
}

variable "instance_count" {
  description = "Number of instance"
  default     = 2
}

variable "web_port" {
  description = "Web access port"
}

variable "environment" {
  description = "Environment"
  type        = "string"
}
