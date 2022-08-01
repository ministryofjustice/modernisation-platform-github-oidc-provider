# Modernisation Platform Github OIDC Provider Module 
[![repo standards badge](https://img.shields.io/badge/dynamic/json?color=blue&style=for-the-badge&logo=github&label=MoJ%20Compliant&query=%24.data%5B%3F%28%40.name%20%3D%3D%20%22modernisation-platform-terraform-github-oidc-provider%22%29%5D.status&url=https%3A%2F%2Foperations-engineering-reports.cloud-platform.service.justice.gov.uk%2Fgithub_repositories)](https://operations-engineering-reports.cloud-platform.service.justice.gov.uk/github_repositories#modernisation-platform-terraform-github-oidc-provider "Link to report")

This module allows users to create an [OIDC Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider)
and the associated IAM resources required to make use of the connect provider.

## Usage

```hcl

module "github-oidc-provider" {

  source                 = "https://github.com/ministryofjustice/modernisation-platform-terraform-github-oidc-provider"
  github_repository      = "ministryofjustice/your-repository-name:*"
  additional_permissions = data.aws_iam_policy_document.extra_permissions.json
  tags_common            = local.tags
  tags_prefix            = terraform.workspace

}

```

The `additional_permissions` variable will allow you to supply any required IAM permissions beyond `ReadOnlyAccess` in the form of
an `aws_iam_policy_document` data call.

<!--- BEGIN_TF_DOCS --->


<!--- END_TF_DOCS --->

## Looking for issues?
If you're looking to raise an issue with this module, please create a new issue in the [Modernisation Platform repository](https://github.com/ministryofjustice/modernisation-platform/issues).
