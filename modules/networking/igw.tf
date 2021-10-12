resource "aws_internet_gateway" "resource-igw" {
  
  vpc_id = var.vpc-id

  tags = {
      Name = "igw-${var.name}-${var.environment}"
  }
}
