data "aws_vpc" "data_vpc" {
  filter {
    name    = "tag:Name"
    values  = ["vpc-${var.sg_env}-${var.sg_name_env}"]
  }
}

data "aws_security_group" "data_sg" {
  filter {
    name    = "description"
    values  = ["default VPC security group"]
  }
  filter {
    name    = "vpc-id"
    values  = ["${data.aws_vpc.data_vpc.id}"]
  }
}