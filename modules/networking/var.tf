#ids
variable "vpc_id" { default = [] }
variable "subnet_id" { default = [] }
variable "route_id" { default = [] }
variable "igw_id" { default = [] }

#others
variable "create" { default = true }
variable "vpc_env" { }

#maps
variable "vpc_rules" {
  type = "map"

  default = {
    prod    = ["10.20.0.0/16", "10.20.0.0/24", "us-east-1a"]
    stage   = ["172.20.0.0/16", "172.20.0.0/24", "us-west-1b"]
  }  
}

variable "auto_vpc_rules" {
  type = "map"
  
  default = {
    prod     = ["aws-hashcat"]
  }
}