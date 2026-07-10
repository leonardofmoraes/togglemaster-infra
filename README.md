# ToggleMaster — Infraestrutura (Terraform)

Infraestrutura como código do projeto **ToggleMaster** (Tech Challenge FIAP/POSTECH),
provisionada via Terraform para uso no **AWS Academy Learner Lab**.

Este repositório é responsável por criar a infraestrutura base sobre a qual o
[`togglemaster-gitops`](https://github.com/leonardofmoraes/togglemaster-gitops)
implanta os microsserviços e a stack de observabilidade via ArgoCD.

## Arquitetura provisionada

- **VPC** com subnets públicas e privadas, 1 NAT Gateway
- **EKS** — cluster Kubernetes gerenciado (2x `t3.medium`)
- **RDS** — banco de dados relacional (`t3.micro`)
- **ElastiCache (Redis)** — cache (`t3.micro`)

> Dimensionamento pensado para o menor custo possível dentro dos créditos do
> AWS Academy — custo estimado em torno de **R$1,60/hora** com a stack completa no ar.

## Pré-requisitos

- Terraform >= 1.10
- AWS CLI configurado com as credenciais temporárias do AWS Academy Learner Lab
- Sessão do Learner Lab **ativa** (status verde) antes de rodar qualquer comando
- Bucket S3 criado previamente para o backend remoto do state (script em `scripts/`)

⚠️ Este projeto usa a **LabRole** disponibilizada pelo AWS Academy — não são criadas
roles/policies de IAM próprias, já que o Learner Lab não permite criação de IAM.

## Como rodar

### 1. Configurar credenciais da sessão

As credenciais do AWS Academy expiram a cada sessão do Lab. Copie as 3 credenciais
temporárias (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_SESSION_TOKEN`) do
painel "AWS Details" do Learner Lab e exporte no seu terminal:

```bash
$env:AWS_ACCESS_KEY_ID="..."
$env:AWS_SECRET_ACCESS_KEY="..."
$env:AWS_SESSION_TOKEN="..."
$env:AWS_REGION="us-east-1"
```

### 2. Provisionar o backend remoto (apenas na primeira vez)

```bash
./scripts/bootstrap-s3-backend.sh.ps1
```

### 3. Provisionar a infraestrutura

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

O `apply` costuma levar **10–15 minutos**, principalmente pela criação do cluster EKS.

### 4. Conectar o kubectl ao cluster

```bash
aws eks update-kubeconfig --name <nome-do-cluster> --region us-east-1
kubectl get nodes
```

A partir daqui, o deploy dos microsserviços e da stack de observabilidade é feito
via GitOps pelo repositório `togglemaster-gitops` (ArgoCD).

### 5. Encerrar (importante!)

Para não consumir créditos do Learner Lab além do necessário:

```bash
terraform destroy
```

## Estrutura

```
terraform/
├── backend.tf         # configuração do backend remoto (S3)
├── main.tf             # composição dos módulos
├── provider.tf          # configuração do provider AWS
├── variables.tf         # variáveis de entrada (região, nome do projeto, ambiente)
├── terraform.tfvars      # valores das variáveis para este ambiente
└── modules/             # módulos reutilizáveis (VPC, EKS, RDS, Redis)
```

## Variáveis principais

| Variável | Descrição | Padrão |
|---|---|---|
| `aws_region` | Região da AWS | `us-east-1` |
| `project_name` | Prefixo usado nos nomes dos recursos | `togglemaster` |
| `environment` | Ambiente (dev, hml, prod) | `dev` |

## Repositórios relacionados

- [`togglemaster-gitops`](https://github.com/leonardofmoraes/togglemaster-gitops) — manifests Kubernetes, ArgoCD e stack de observabilidade
- [`togglemaster-local-dev`](https://github.com/leonardofmoraes/togglemaster-local-dev) — ambiente de desenvolvimento local via docker-compose
