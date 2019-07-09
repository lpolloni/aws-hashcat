resource "aws_subnet" "resource_subnet" {
  count   = "${var.create ? length(var.auto_vpc_rules[var.vpc_env]) : 0}"

  vpc_id            = "${element(var.vpc_id, count.index)}" 
  cidr_block        = "${element(var.vpc_rules[var.vpc_env], 1)}"
  availability_zone = "${element(var.vpc_rules[var.vpc_env], 2)}"

  tags {
    Name  = "subnet-${var.vpc_env}-${element(var.auto_vpc_rules[var.vpc_env], count.index)}"
  }
}