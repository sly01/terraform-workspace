############ ROUTE 53 #######

resource "aws_route53_zone" "dns_zone" {
  name              = "${var.domain_name}.tk."
  delegation_set_id = "${var.delegation_set}"
}

resource "aws_route53_record" "subdomain" {
  name    = "${var.environment}.${var.domain_name}.tk"
  type    = "A"
  zone_id = "${aws_route53_zone.dns_zone.id}"

  alias {
    name                   = "${aws_elb.elb.dns_name}"
    zone_id                = "${aws_elb.elb.zone_id}"
    evaluate_target_health = false
  }
}

