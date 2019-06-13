output "availability_zone_list" {
  value = "${data.aws_availability_zones.available.names}"
}
