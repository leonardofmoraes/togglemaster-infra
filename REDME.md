# ToggleMaster — Infraestrutura (Terraform)

Infraestrutura como código do projeto ToggleMaster (Tech Challenge FIAP/POSTECH),
provisionada via Terraform para uso no AWS Academy (Learner Lab).

## Pré-requisitos
- Terraform >= 1.10
- AWS CLI configurado com as credenciais do AWS Academy
- Bucket S3 criado previamente para o backend remoto (ver `scripts/`)

## Como rodar

\`\`\`bash
cd terraform
terraform init
terraform plan
terraform apply
\`\`\`

## Estrutura

\`\`\`
terraform/
├── backend.tf       # backend remoto S3
├── provider.tf
├── main.tf
├── variables.tf
└── modules/
    ├── networking/  # VPC, subnets, IGW, route tables
    ├── eks/         # Cluster EKS + Node Groups (LabRole)
    ├── database/    # RDS PostgreSQL
    ├── cache/       # ElastiCache Redis
    ├── dynamodb/    # ToggleMasterAnalytics
    ├── sqs/         # Fila de mensageria
    └── ecr/         # Repositórios de imagens Docker
\`\`\`

## Repositórios relacionados
- GitOps: _(adicionar link quando criado)_
- Microsserviços: _(adicionar link quando criado)_

## Autores
- Nome — RM