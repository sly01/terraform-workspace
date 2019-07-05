variable "env" {
  description = "env: dev or prod"
}

variable "instance_type" {
  description = "Flavor of instance"
  type        = "map"
}
