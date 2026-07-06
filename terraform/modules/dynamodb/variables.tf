variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "billing_mode" {
  type    = string
  default = "PAY_PER_REQUEST" # Sem custo fixo, cobra só pelo uso — ideal para Academy
}