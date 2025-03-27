# Modernisation Platform Github OIDC Provider Module
[![Standards Icon]][Standards Link] [![Format Code Icon]][Format Code Link] [![Scorecards Icon]][Scorecards Link][![SCA Icon]][SCA Link] [![Terraform SCA Icon]][Terraform SCA Link]

This module allows users to create an [OIDC Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider)
and the associated IAM resources required to make use of the connect provider.

## Usage

```hcl

module "github-oidc-provider" {

  source                 = "https://github.com/ministryofjustice/modernisation-platform-terraform-github-oidc-provider"
  github_repositories    = ["ministryofjustice/your-repository-name:*"]
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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_openid_connect_provider.github_actions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_policy.extra_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.github_actions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.additional_managed_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.extra_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.read_only](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.github_oidc_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [tls_certificate.github](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_managed_policies"></a> [additional\_managed\_policies](#input\_additional\_managed\_policies) | accept a list of arns for aws managed policies to attach to OIDC-provider role | `list(string)` | `[]` | no |
| <a name="input_additional_permissions"></a> [additional\_permissions](#input\_additional\_permissions) | accept aws\_iam\_policy\_document with additional permissions to attach to the OIDC-provider role | `string` | n/a | yes |
| <a name="input_github_known_thumbprints"></a> [github\_known\_thumbprints](#input\_github\_known\_thumbprints) | The known intermediary thumbprints for the GitHub OIDC provider | `list(string)` | <pre>[<br/>  "1c58a3a8518e8759bf075b76b750d4f2df264fcd",<br/>  "6938fd4d98bab03faadb97b34396831e3780aea1"<br/>]</pre> | no |
| <a name="input_github_repositories"></a> [github\_repositories](#input\_github\_repositories) | The github repositories, for example ["ministryofjustice/modernisation-platform-environments:*"] | `list(string)` | n/a | yes |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | OIDC Role Name | `string` | `"github-actions"` | no |
| <a name="input_tags_common"></a> [tags\_common](#input\_tags\_common) | MOJ required tags | `map(string)` | n/a | yes |
| <a name="input_tags_prefix"></a> [tags\_prefix](#input\_tags\_prefix) | prefix for name tags | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_github_actions_provider"></a> [github\_actions\_provider](#output\_github\_actions\_provider) | This module configures an OIDC provider for use with GitHub actions |
| <a name="output_github_actions_role"></a> [github\_actions\_role](#output\_github\_actions\_role) | IAM Role created for use by the OIDC provider |
| <a name="output_github_actions_role_trust_policy"></a> [github\_actions\_role\_trust\_policy](#output\_github\_actions\_role\_trust\_policy) | Assume role policy for the github-actions role |
<!-- END_TF_DOCS -->

[Standards Link]: https://github-community.cloud-platform.service.justice.gov.uk/repository-standards/modernisation-platform-github-oidc-provider "Repo standards badge."
[Standards Icon]: https://github-community.cloud-platform.service.justice.gov.uk/repository-standards/api/modernisation-platform-github-oidc-provider/badge
[Format Code Icon]: https://img.shields.io/github/actions/workflow/status/ministryofjustice/modernisation-platform-github-oidc-provider/format-code.yml?labelColor=231f20&style=for-the-badge&label=Formate%20Code
[Format Code Link]: https://github.com/ministryofjustice/modernisation-platform-github-oidc-provider/actions/workflows/format-code.yml
[Scorecards Icon]: https://img.shields.io/github/actions/workflow/status/ministryofjustice/modernisation-platform-github-oidc-provider/scorecards.yml?branch=main&labelColor=231f20&style=for-the-badge&label=Scorecards
[Scorecards Link]: https://github.com/ministryofjustice/modernisation-platform-github-oidc-provider/actions/workflows/scorecards.yml
[SCA Icon]: https://img.shields.io/github/actions/workflow/status/ministryofjustice/modernisation-platform-github-oidc-provider/code-scanning.yml?branch=main&labelColor=231f20&style=for-the-badge&label=Secure%20Code%20Analysis
[SCA Link]: https://github.com/ministryofjustice/modernisation-platform-github-oidc-provider/actions/workflows/code-scanning.yml
[Terraform SCA Icon]: https://img.shields.io/github/actions/workflow/status/ministryofjustice/modernisation-platform-github-oidc-provider/code-scanning.yml?branch=main&labelColor=231f20&style=for-the-badge&label=Terraform%20Static%20Code%20Analysis
[Terraform SCA Link]: https://github.com/ministryofjustice/modernisation-platform-github-oidc-provider/actions/workflows/terraform-static-analysis.yml
