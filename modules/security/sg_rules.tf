resource "aws_security_group_rule" "ingress_rules" {
  count = "${var.create ? length(var.auto_ingress_rules[var.sg_name_env]) : 0}"

  type              = "ingress"
  from_port         = "${element(var.ingress_rules[element(var.auto_ingress_rules[var.sg_name_env], count.index)], 0)}"
  to_port           = "${element(var.ingress_rules[element(var.auto_ingress_rules[var.sg_name_env], count.index)], 1)}"
  protocol          = "${element(var.ingress_rules[element(var.auto_ingress_rules[var.sg_name_env], count.index)], 2)}"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "${element(var.ingress_rules[element(var.auto_ingress_rules[var.sg_name_env], count.index)], 3)}"
  security_group_id = "${var.sg_id}"
}