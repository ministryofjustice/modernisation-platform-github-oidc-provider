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
