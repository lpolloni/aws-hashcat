resource "aws_internet_gateway" "resource_igw" {
  count   = "${var.create ? length(var.auto_vpc_rules[var.vpc_env]) : 0}"

  vpc_id  = "${element(var.vpc_id, count.index)}"

  tags {
    Name  = "igw-${var.vpc_env}-${element(var.auto_vpc_rules[var.vpc_env], count.index)}"
  } 
}