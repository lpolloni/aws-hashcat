resource "aws_vpc" "resource_vpc" {
  count = "${var.create ? length(var.auto_vpc_rules[var.vpc_env]) : 0}"

  cidr_block  = "${element(var.vpc_rules[var.vpc_env], 0)}"

  tags {
    Name = "vpc-${var.vpc_env}-${element(var.auto_vpc_rules[var.vpc_env], count.index)}"
  } 
}