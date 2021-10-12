# main
variable "name" {
    default = "aws-hcat"
}
variable "environment" {
    default = "prod"
}
variable "create" {
    default = true
}

# ids
variable "vpc-id" {}
variable "subnet-id" {}
variable "sgroup-id" {}

# map
variable "ec2-type" {
    # instance type
    default = {
        prod = ["p3.2xlarge"]
        stage = ["t2.micro"]
    }
}
variable "availability-zones" {
    # az for instances
    default = {
        prod = ["us-east-2a", "us-east-2b"]
        stage = ["us-west-2a", "us-west-2b"]
    }
}
