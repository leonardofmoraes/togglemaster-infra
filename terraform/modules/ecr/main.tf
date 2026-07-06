resource "aws_ecr_repository" "main" {
  for_each = toset(var.services)

  name                 = "${var.project_name}-${var.environment}-${each.key}"
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = true # Scan automático de vulnerabilidades a cada push (reforça o requisito de Security Scan da Fase 3)
  }

  tags = {
    Name    = "${var.project_name}-${var.environment}-${each.key}"
    Service = each.key
  }
}

# Política de lifecycle: mantém só as últimas 10 imagens por repositório, economiza armazenamento
resource "aws_ecr_lifecycle_policy" "main" {
  for_each   = aws_ecr_repository.main
  repository = each.value.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Mantem apenas as ultimas 10 imagens"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 10
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}