variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "services" {
  description = "Lista dos microsserviços que terão repositório no ECR"
  type        = list(string)
  default     = ["auth-service", "flag-service", "targeting-service", "evaluation-service", "analytics-service"]
}

variable "image_tag_mutability" {
  type    = string
  default = "IMMUTABLE" # Boa prática: uma tag já enviada não pode ser sobrescrita
}