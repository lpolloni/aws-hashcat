resource "aws_route_table" "resource_route" {
  count   = "${var.create ? length(var.auto_vpc_rules[var.vpc_env]) : 0}"
  
  vpc_id  = "${element(var.vpc_id, count.index)}"

  route {
    cidr_block  = "0.0.0.0/0"
    gateway_id  = "${element(var.igw_id, count.index)}"
  }

  tags {
    Name  = "route-${var.vpc_env}-${element(var.auto_vpc_rules[var.vpc_env], count.index)}"
  }
}

resource "aws_route_table_association" "resource_route_assiciation" {
  count   = "${var.create ? length(var.auto_vpc_rules[var.vpc_env]) : 0}"

  route_table_id  = "${element(var.route_id, count.index)}"
  subnet_id       = "${element(var.subnet_id, count.index)}"
}