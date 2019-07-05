output "public_subnets" {
  value = "${module.networking.public_subnets}"
}

output "private_subnets" {
  value = "${module.networking.private_subnets}"
}

output "elb-sg" {
  value = "${module.networking.elb-sg}"
}

output "elb-to-ec2" {
  value = "${module.networking.elb-to-ec2}"
}

output "ansible-management-sg" {
  value = "${module.networking.ansible-management-sg}"
}
