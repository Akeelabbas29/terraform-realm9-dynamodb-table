# terraform-realm9-dynamodb-table

Terraform project for testing Realm9 end-to-end. Provisions a DynamoDB table **plus** an IAM user with access keys scoped to that table only, so you can verify CLI access from outside Realm9.

## Resources Created

- **DynamoDB Table** — on-demand or provisioned, server-side encrypted, optional GSI / TTL / PITR
- **IAM User** — `<table_name>-user` under path `/realm9-test/`
- **IAM User Policy** — inline policy granting CRUD on this table only (no `*` wildcard on resources)
- **IAM Access Key** — programmatic access key for the user

A random suffix is appended to all resource names so the project can be applied multiple times in the same account.

## Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `aws_region` | AWS region | `us-east-1` |
| `project_name` | Project name for naming | `realm9` |
| `environment` | Environment | `dev` |
| `billing_mode` | `PAY_PER_REQUEST` or `PROVISIONED` | `PAY_PER_REQUEST` |
| `hash_key` | Partition key name | `id` |
| `hash_key_type` | Partition key type (S/N/B) | `S` |
| `range_key` | Sort key name (optional) | `""` |
| `ttl_attribute` | TTL attribute name (optional) | `""` |
| `point_in_time_recovery` | Enable PITR | `false` |
| `kms_key_arn` | KMS key ARN (optional) | `""` |
| `global_secondary_indexes` | GSI definitions | `[]` |
| `tags` | Additional tags | `{}` |

## Outputs

| Output | Sensitive | Description |
|--------|-----------|-------------|
| `table_name` | no | Final DynamoDB table name (with random suffix) |
| `table_arn` | no | DynamoDB table ARN |
| `region` | no | AWS region |
| `iam_user_name` | no | IAM user with table-scoped access |
| `iam_user_arn` | no | IAM user ARN |
| `access_key_id` | yes | AWS access key ID for the user |
| `secret_access_key` | yes | AWS secret access key for the user |

## CLI verification flow

After Realm9 applies the project, copy the outputs and:

```sh
export AWS_ACCESS_KEY_ID="<access_key_id>"
export AWS_SECRET_ACCESS_KEY="<secret_access_key>"
export AWS_DEFAULT_REGION="<region>"
TABLE="<table_name>"

# 1. Describe the table (proves the user can read metadata)
aws dynamodb describe-table --table-name "$TABLE" --query 'Table.{Name:TableName,Status:TableStatus}'

# 2. Write an item
aws dynamodb put-item --table-name "$TABLE" \
  --item '{"id":{"S":"test-1"},"message":{"S":"hello from realm9"}}'

# 3. Read it back
aws dynamodb scan --table-name "$TABLE"

# 4. Negative test — try a different table (should be Denied, proves scoping)
aws dynamodb scan --table-name some-other-table
```

After Realm9 destroys the project, run the `describe-table` command again — should fail with `ResourceNotFoundException` (table gone) AND/OR `InvalidClientTokenId` (IAM user gone).

## Cost

DynamoDB on-demand: $0 idle, pay-per-request.
IAM user/policy/key: always free.

## Security

- Server-side encryption always on
- IAM user policy is scoped to the specific table ARN — no wildcard resource access
- Access keys are sensitive outputs and should never be logged or displayed in plaintext
