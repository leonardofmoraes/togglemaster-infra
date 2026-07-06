output "repository_urls" {
  description = "URL de cada repositório ECR, por serviço"
  value       = { for k, repo in aws_ecr_repository.main : k => repo.repository_url }
}

output "repository_arns" {
  value = { for k, repo in aws_ecr_repository.main : k => repo.arn }
}