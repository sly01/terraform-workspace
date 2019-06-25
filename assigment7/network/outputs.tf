output "public_subnets" {
  value = "${aws_subnet.public_subnet.*.id}"
}

output "private_subnets" {
  value = "${aws_subnet.private_subnet.*.id}"
}

output "elb-sg" {
  value = "${aws_security_group.elb-sg.id}"
}

output "elb-to-ec2" {
  value = "${aws_security_group.elb-to-ec2.id}"
}

output "ansible-management-sg" {
  value = "${aws_security_group.ansible-management-sg.id}"
}
