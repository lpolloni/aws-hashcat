resource "aws_vpc" "resource-vpc" {

  cidr_block = var.cidr-block-vpc[var.environment]

  tags = {
    Name = "vpc-${var.name}-${var.environment}"
  }
}
