variable "github_repositories" {
  type        = list(string)
  description = "The github repositories, for example [\"ministryofjustice/modernisation-platform-environments:*\"]"
  validation {
    condition     = length(var.github_repositories) > 0
    error_message = "At least one repository must be specified."
  }

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

# tflint-ignore: terraform_unused_declarations
variable "tags_prefix" {
  description = "prefix for name tags"
  type        = string
}
