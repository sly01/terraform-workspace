output "elb_public_dns_name" {
  value = "${aws_elb.example_elb.dns_name}"
}
