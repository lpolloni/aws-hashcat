provider "aws" {
  region  = "us-east-1"
}

module "create_vpc" {
  source      = "../../modules/networking" 
  
  vpc_env     = "prod"
  vpc_id      = "${module.create_vpc.o_vpc_id}"
  igw_id      = "${module.create_vpc.o_igw_id}"
  route_id    = "${module.create_vpc.o_route_id}"
  subnet_id   = "${module.create_vpc.o_subnet_id}"
}