output "aws_public_ip" {
  value = "${aws_instance.web.*.public_ip}"
}

output "aws_elb_public_dns" {
  value = "${aws_elb.elb.dns_name}"
}
