module "networking" {
  source = "./modules/networking"

  project_name = var.project_name
  environment  = var.environment
  vpc_cidr     = "10.0.0.0/16"
}

module "eks" {
  source = "./modules/eks"

  project_name        = var.project_name
  environment         = var.environment
  vpc_id              = module.networking.vpc_id
  private_subnet_ids  = module.networking.private_subnet_ids
  public_subnet_ids   = module.networking.public_subnet_ids
}

module "database" {
  source = "./modules/database"

  project_name        = var.project_name
  environment         = var.environment
  vpc_id              = module.networking.vpc_id
  vpc_cidr            = module.networking.vpc_cidr
  private_subnet_ids  = module.networking.private_subnet_ids
  db_password         = var.db_password
}

variable "db_password" {
  type      = string
  sensitive = true
}

module "cache" {
  source = "./modules/cache"

  project_name        = var.project_name
  environment         = var.environment
  vpc_id              = module.networking.vpc_id
  vpc_cidr            = module.networking.vpc_cidr
  private_subnet_ids  = module.networking.private_subnet_ids
}

module "dynamodb" {
  source = "./modules/dynamodb"

  project_name = var.project_name
  environment  = var.environment
}

module "sqs" {
  source = "./modules/sqs"

  project_name = var.project_name
  environment  = var.environment
}

module "ecr" {
  source = "./modules/ecr"

  project_name = var.project_name
  environment  = var.environment
}