variable "github_repository" {
  type        = string
  description = "The github repository, for example ministryofjustice/modernisation-platform-environments:*"
}

variable "additional_permissions" {
  type        = string
  description = "accept aws_iam_policy_document with additional permissions to attach to the github-actions role"
}

variable "additional_managed_policies" {
  type        = list(string)
  description = "accept a list of arns for aws managed policies to attach to github-actions role"
  default     = []
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
