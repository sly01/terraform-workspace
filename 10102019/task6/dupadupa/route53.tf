data "aws_route53_zone" "dns_zone" {
  count = "${var.dns_zone_creation ? 0 : 1}"
  name  = "${var.domain_name}.tk."
}

resource "aws_route53_zone" "primary" {
  count             = "${var.dns_zone_creation ? 1 : 0}"
  name              = "${var.domain_name}.tk"
  delegation_set_id = "${var.delegation_set}"
}

resource "aws_route53_record" "subdomain" {
  name    = "${var.env}.${var.domain_name}.tk"
  type    = "A"
  zone_id = "${var.dns_zone_creation ? aws_route53_zone.primary.*.id[0] : data.aws_route53_zone.dns_zone.*.id[0]}"

  alias {
    name                   = "${aws_elb.elb.dns_name}"
    zone_id                = "${aws_elb.elb.zone_id}"
    evaluate_target_health = false
  }
}
