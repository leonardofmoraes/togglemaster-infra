variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_engine_version" {
  type    = string
  default = "16.4"
}

variable "db_allocated_storage" {
  type    = number
  default = 20
}

variable "db_username" {
  type      = string
  default   = "toggleadmin"
  sensitive = true
}

variable "db_password" {
  type      = string
  sensitive = true
}

# Nome de cada banco -> um por microsserviço que precisa de RDS
variable "databases" {
  type    = list(string)
  default = ["auth", "flag", "targeting"]
}