# ToggleMaster — Infraestrutura (Terraform)

Infraestrutura como código do projeto ToggleMaster (Tech Challenge FIAP/POSTECH),
provisionada via Terraform para uso no AWS Academy (Learner Lab).

## Pré-requisitos

- Terraform >= 1.10
- AWS CLI configurado com as credenciais do AWS Academy
- Bucket S3 criado previamente para o backend remoto (ver `scripts/`)

## Como rodar

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

## Estrutura