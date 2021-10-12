resource "aws_subnet" "resource-subnet" {
  count = var.create ? length(var.cidr-block-subnet[var.environment]) : 0

  vpc_id = var.vpc-id
  cidr_block = element(var.cidr-block-subnet[var.environment], count.index)
  availability_zone = element(var.availability-zones[var.environment], count.index)

  tags = {
    Name = "subnet-${var.name}-${var.environment}-${count.index}"
  }
}
