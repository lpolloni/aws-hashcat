# main
variable "name" {
  default = "aws-hcat"
}
variable "environment" {
  default = "prod"
}

#ids
variable "vpc-id" {}
variable "igw-id" {}
variable "subnet-id" {}

#maps
variable "availability-zones" {
  default = {
    prod = ["us-east-2a", "us-east-2b"]
    stage = ["us-west-2a", "us-west-2b"]
  }
}
variable "cidr-block-vpc" {
  default = {
    prod = "10.10.0.0/16"
    stage = ""
  }
}
variable "cidr-block-subnet" {
  default = {
    prod = ["10.10.0.0/24"]
    stage = [""]
  }
}

# other
variable "create" {
  default = true
}
