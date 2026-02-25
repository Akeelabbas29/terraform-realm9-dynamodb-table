variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "realm9"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "billing_mode" {
  description = "Billing mode: PAY_PER_REQUEST or PROVISIONED"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "hash_key" {
  description = "Partition key name"
  type        = string
  default     = "id"
}

variable "hash_key_type" {
  description = "Partition key type (S = String, N = Number, B = Binary)"
  type        = string
  default     = "S"
}

variable "range_key" {
  description = "Sort key name (leave empty for no sort key)"
  type        = string
  default     = ""
}

variable "range_key_type" {
  description = "Sort key type (S = String, N = Number, B = Binary)"
  type        = string
  default     = "S"
}

variable "read_capacity" {
  description = "Read capacity units (only for PROVISIONED billing)"
  type        = number
  default     = 5
}

variable "write_capacity" {
  description = "Write capacity units (only for PROVISIONED billing)"
  type        = number
  default     = 5
}

variable "additional_attributes" {
  description = "Additional attributes for GSIs/LSIs"
  type = list(object({
    name = string
    type = string
  }))
  default = []
}

variable "global_secondary_indexes" {
  description = "Global secondary index definitions"
  type = list(object({
    name            = string
    hash_key        = string
    range_key       = optional(string)
    projection_type = optional(string, "ALL")
    read_capacity   = optional(number, 5)
    write_capacity  = optional(number, 5)
  }))
  default = []
}

variable "ttl_attribute" {
  description = "TTL attribute name (leave empty to disable TTL)"
  type        = string
  default     = ""
}

variable "point_in_time_recovery" {
  description = "Enable point-in-time recovery"
  type        = bool
  default     = false
}

variable "kms_key_arn" {
  description = "KMS key ARN for encryption. If empty, uses AWS-managed key"
  type        = string
  sensitive   = true
  default     = ""
}

variable "tags" {
  description = "Additional tags to apply"
  type        = map(string)
  default     = {}
}
