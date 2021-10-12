provider "aws" {
  region = "us-east-2"
}

module "create-networking" {
  source = "./modules/networking"
  vpc-id = module.create-networking.o-vpc-id
  igw-id = module.create-networking.o-igw-id
  subnet-id = module.create-networking.o-subnet-id
}

module "create-compute" {
  source = "./modules/compute"
  vpc-id = module.create-networking.o-vpc-id
  sgroup-id = [module.create-networking.o-sgroup-id]
  subnet-id = module.create-networking.o-subnet-id
}
