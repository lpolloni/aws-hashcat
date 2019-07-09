resource "aws_security_group" "resource_sg" {

  name         = "${var.sg_env}-${var.sg_name_env}-sg"
  description  = "sg-${var.sg_env}-${var.sg_name_env}"
  vpc_id       = "${var.vpc_id}"

  tags {
    Name = "sg-${var.sg_env}-${var.sg_name_env}"
  }
}

resource "aws_security_group_rule" "egress_rules" {

  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${var.sg_id}"
}