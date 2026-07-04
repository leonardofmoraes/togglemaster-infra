# ToggleMaster — Infraestrutura (Terraform)

Infraestrutura como código do projeto ToggleMaster, provisionada via Terraform 
para uso no AWS Academy (Learner Lab).

## Pré-requisitos
- Terraform >= 1.10
- AWS CLI configurado com as credenciais do Academy
- Bucket S3 criado previamente para o backend remoto (ver `scripts/`)

## Como rodar
\`\`\`bash
cd terraform
terraform init
terraform plan
terraform apply
\`\`\`

## Repositórios relacionados
- GitOps: [togglemaster-gitops](link)
- Microsserviços: [togglemaster-services](link)

## Estrutura
Ver `terraform/modules/` para os módulos de: networking, eks, database, cache, dynamodb, sqs, ecr.