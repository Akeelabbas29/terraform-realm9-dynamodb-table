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

output "region" {
  description = "AWS region"
  value       = var.aws_region
}

output "iam_user_name" {
  description = "IAM user with table-scoped access"
  value       = aws_iam_user.table_user.name
}

output "iam_user_arn" {
  description = "ARN of the IAM user"
  value       = aws_iam_user.table_user.arn
}

output "access_key_id" {
  description = "Access key ID for the IAM user — use for AWS CLI verification"
  value       = aws_iam_access_key.table_user.id
  sensitive   = true
}

output "secret_access_key" {
  description = "Secret access key for the IAM user — use for AWS CLI verification"
  value       = aws_iam_access_key.table_user.secret
  sensitive   = true
}
