variable "tags" {
  type        = map(string)
  description = "Common tags to be used by all resources"
}
variable "application_name" {
  type        = string
  description = "Name of application"
}

variable "github_repository" {
  type        = string
  description = "The github repository, for example ministryofjustice/modernisation-platform-environments:*"
}

variable "additional_permissions" {
  type        = aws_iam_policy_document
  description = "accept aws_iam_policy_document with additional permissions to attach to the github-actions role"
}
