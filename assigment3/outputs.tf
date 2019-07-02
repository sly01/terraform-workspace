output "server1_public_hostname" {
  value = "${aws_instance.server1.public_dns}"
}

output "availability_zone_list" {
  value = "${data.aws_availability_zones.available.names}"
}
