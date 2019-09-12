output "elb_dns_name" {
  value = "${module.something.aws_elb_public_dns}"
}
