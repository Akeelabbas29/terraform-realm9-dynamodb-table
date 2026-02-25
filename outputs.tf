output "table_name" {
  description = "Name of the DynamoDB table"
  value       = aws_dynamodb_table.this.name
}

output "table_arn" {
  description = "ARN of the DynamoDB table"
  value       = aws_dynamodb_table.this.arn
}

output "table_id" {
  description = "ID of the DynamoDB table"
  value       = aws_dynamodb_table.this.id
}

output "hash_key" {
  description = "Hash key of the table"
  value       = aws_dynamodb_table.this.hash_key
}

output "range_key" {
  description = "Range key of the table (if configured)"
  value       = aws_dynamodb_table.this.range_key
}

output "billing_mode" {
  description = "Billing mode of the table"
  value       = var.billing_mode
}

output "encryption_type" {
  description = "Encryption type"
  value       = var.kms_key_arn != "" ? "KMS (customer-managed)" : "AWS-managed"
}
