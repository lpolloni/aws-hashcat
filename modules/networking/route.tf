resource "aws_route_table" "resource-route" {
  vpc_id = var.vpc-id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = var.igw-id
  }

  tags = {
      Name = "route-${var.name}-${var.environment}"
  }
}

resource "aws_route_table_association" "resource-route-association" {
  count = var.create ? length(var.cidr-block-subnet[var.environment]) : 0

  route_table_id = aws_route_table.resource-route.id
  subnet_id = element(var.subnet-id, count.index)
}
