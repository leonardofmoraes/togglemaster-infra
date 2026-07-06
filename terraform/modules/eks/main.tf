# Busca a LabRole já existente na conta (obrigatório no AWS Academy)
data "aws_iam_role" "lab_role" {
  name = "LabRole"
}

resource "aws_eks_cluster" "main" {
  name     = "${var.project_name}-${var.environment}-eks"
  role_arn = data.aws_iam_role.lab_role.arn
  version  = var.kubernetes_version

  vpc_config {
    subnet_ids              = concat(var.private_subnet_ids, var.public_subnet_ids)
    endpoint_public_access   = true
    endpoint_private_access  = true
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-eks"
  }
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.project_name}-${var.environment}-ng"
  node_role_arn   = data.aws_iam_role.lab_role.arn
  subnet_ids      = var.private_subnet_ids

  scaling_config {
    desired_size = var.node_desired_size
    min_size     = var.node_min_size
    max_size     = var.node_max_size
  }

  instance_types = [var.node_instance_type]

  tags = {
    Name = "${var.project_name}-${var.environment}-node-group"
  }

  # Garante que o cluster exista antes do node group
  depends_on = [aws_eks_cluster.main]
}