provider "aws" {
  region  = "us-east-1"
}

module "create_sg" {
  source = "../../modules/security"

  sg_env       = "prod"
  sg_name_env  = "aws-hashcat"
  vpc_id       = "${module.create_sg.o_vpc_id}"
  sg_id        = "${module.create_sg.o_sg_id}"
}

module "create_ec2" {
  source = "../../modules/compute"

  ec2_env      = "prod"
  ec2_av       = "us-east-1a"
  vpc_id       = "${module.create_sg.o_vpc_id}"
  ami_id       = "${module.create_ec2.o_debian_id}"
  subnet_id    = "${module.create_ec2.o_subnet_id}"
  sg_ids       = ["${module.create_sg.o_sg_id}"]
}