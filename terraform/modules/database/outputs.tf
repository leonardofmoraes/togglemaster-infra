output "db_endpoints" {
  description = "Endpoint de cada banco, por serviço"
  value       = { for k, db in aws_db_instance.main : k => db.endpoint }
}

output "db_security_group_id" {
  value = aws_security_group.rds.id
}