# Script de bootstrap do backend remoto do Terraform (rodar 1x, manualmente)
# Substitua o nome do bucket se for reutilizar este script em outro ambiente

aws s3api create-bucket --bucket togglemaster-tfstate-369910 --region us-east-1

aws s3api put-bucket-versioning --bucket togglemaster-tfstate-369910 --versioning-configuration Status=Enabled