resource "aws_iam_user" "table_user" {
  name = "${local.table_name}-user"
  path = "/realm9-test/"

  tags = merge(
    {
      Name        = "${local.table_name}-user"
      Environment = var.environment
      ManagedBy   = "Terraform"
    },
    var.tags
  )
}

resource "aws_iam_user_policy" "table_access" {
  name = "${local.table_name}-access"
  user = aws_iam_user.table_user.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "dynamodb:DescribeTable",
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:UpdateItem",
        "dynamodb:DeleteItem",
        "dynamodb:Query",
        "dynamodb:Scan",
        "dynamodb:BatchGetItem",
        "dynamodb:BatchWriteItem",
      ]
      Resource = [
        aws_dynamodb_table.this.arn,
        "${aws_dynamodb_table.this.arn}/index/*",
      ]
    }]
  })
}

resource "aws_iam_access_key" "table_user" {
  user = aws_iam_user.table_user.name
}
