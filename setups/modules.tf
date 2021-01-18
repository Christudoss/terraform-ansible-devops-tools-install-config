module "networking" {
  source = "../modules/networking"
  cidr_block = var.cidr_block
}

module "artifactory" {
  source = "../modules/artifactory"
  vpc_id = module.networking.vpc_id
  subnet_id = module.networking.subnet_id
  
      
  }
}