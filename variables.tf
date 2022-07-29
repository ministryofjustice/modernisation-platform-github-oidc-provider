variable "app_name" {
  type        = string
  description = "Name of application"
  validation {
    condition     = can(regex("^[A-Za-z0-9][A-Za-z0-9-.]{1,61}[A-Za-z0-9]$", var.app_name))
    error_message = "Invalid name for application supplied in variable app_name."
  }
}

variable "github_repository" {
  type        = string
  description = "The github repository, for example ministryofjustice/modernisation-platform-environments:*"
}

variable "additional_permissions" {
  type        = string
  description = "accept aws_iam_policy_document with additional permissions to attach to the github-actions role"
}

## Tags / Prefix
variable "tags_common" {
  description = "MOJ required tags"
  type        = map(string)
}

variable "tags_prefix" {
  description = "prefix for name tags"
  type        = string
}
