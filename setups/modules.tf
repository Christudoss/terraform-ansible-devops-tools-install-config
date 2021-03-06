module "networking" {
  source = "../modules/networking"
  cidr_block = var.cidr_block
}

module "artifactory" {
  source = "../modules/artifactory"
  vpc_id = module.networking.vpc_id
  subnet_id = module.networking.subnet_id
  cidr_block = var.cidr_block
  ssh_user = var.ssh_user
  private_key_path = var.private_key_path
      
}
