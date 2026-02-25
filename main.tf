terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

locals {
  param_name = "/${var.project_name}/${var.environment}/${random_string.suffix.result}"
}

# SSM Parameter
resource "aws_ssm_parameter" "this" {
  name  = local.param_name
  type  = "String"
  value = var.parameter_value

  tags = merge(
    {
      Name        = local.param_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    },
    var.tags
  )
}
