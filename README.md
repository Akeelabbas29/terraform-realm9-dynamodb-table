# Terraform AWS SSM Parameter (terraform-realm9-3)

Creates a single AWS SSM Parameter Store entry. Zero cost (standard tier). Fully idempotent — random suffix prevents name conflicts.

## Resources Created

- **SSM Parameter** — that's it

## Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `aws_region` | AWS region | `us-east-1` |
| `project_name` | Project name | `realm9` |
| `environment` | Environment | `dev` |
| `parameter_value` | Value to store | `managed-by-terraform` |
| `tags` | Additional tags | `{}` |

## Usage

```bash
terraform init
terraform plan
terraform apply
terraform destroy
```
