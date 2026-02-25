# Terraform AWS DynamoDB Table (terraform-realm9-3)

Terraform module for provisioning AWS DynamoDB tables. Fully idempotent — safe to apply multiple times across multiple projects.

## Resources Created

- **DynamoDB Table** — on-demand or provisioned, with encryption
- Optional GSIs, TTL, and point-in-time recovery

No IAM roles, no security groups, no globally-scoped resources. Every resource uses a random suffix to guarantee uniqueness.

## Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `aws_region` | AWS region | `us-east-1` |
| `project_name` | Project name for naming | `realm9` |
| `environment` | Environment | `dev` |
| `billing_mode` | PAY_PER_REQUEST or PROVISIONED | `PAY_PER_REQUEST` |
| `hash_key` | Partition key name | `id` |
| `hash_key_type` | Partition key type (S/N/B) | `S` |
| `range_key` | Sort key name (optional) | `""` |
| `ttl_attribute` | TTL attribute name (optional) | `""` |
| `point_in_time_recovery` | Enable PITR | `false` |
| `kms_key_arn` | KMS key for encryption (sensitive) | `""` |
| `global_secondary_indexes` | GSI definitions | `[]` |
| `tags` | Additional tags | `{}` |

## Usage

```bash
terraform init
terraform plan
terraform apply
terraform destroy
```

## Security

- Server-side encryption always enabled (AWS-managed or KMS)
- All resource names include random suffix to prevent conflicts
- PAY_PER_REQUEST by default — no capacity planning needed
