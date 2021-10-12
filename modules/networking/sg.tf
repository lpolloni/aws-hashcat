resource "aws_security_group" "resource-sgroup" {
  
  name = "sgroup-${var.name}-${var.environment}"
  description = "Created with Terraform, used for ${var.name} on environment ${var.environment}"
  vpc_id = var.vpc-id
  
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "ssh access"
  }
  ingress {
      from_port = "-1"
      to_port = "-1"
      protocol = "icmp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "ping"
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "outbound internet access"
  }

  tags = {
      Name = "sgroup-${var.name}-${var.environment}"
  }
}
