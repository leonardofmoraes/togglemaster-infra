resource "aws_dynamodb_table" "analytics" {
  name         = "ToggleMasterAnalytics"
  billing_mode = var.billing_mode
  hash_key     = "event_id"

  attribute {
    name = "event_id"
    type = "S"
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-analytics"
    Environment = var.environment
  }
}