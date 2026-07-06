resource "aws_sqs_queue" "main" {
  name                       = "${var.project_name}-${var.environment}-queue"
  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.message_retention_seconds

  tags = {
    Name = "${var.project_name}-${var.environment}-queue"
  }
}

# Dead Letter Queue — boa prática para não perder mensagens que falham
resource "aws_sqs_queue" "dlq" {
  name                      = "${var.project_name}-${var.environment}-queue-dlq"
  message_retention_seconds = 1209600 # 14 dias

  tags = {
    Name = "${var.project_name}-${var.environment}-queue-dlq"
  }
}

resource "aws_sqs_queue_redrive_policy" "main" {
  queue_url = aws_sqs_queue.main.id

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 5
  })
}