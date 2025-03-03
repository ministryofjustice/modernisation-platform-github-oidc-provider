package main

import (
	"regexp"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestGitHubOIDCProviderCreation(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "./unit-test",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	github_actions_provider := terraform.Output(t, terraformOptions, "github_actions_provider")
	github_actions_role_trust_policy_conditions := terraform.Output(t, terraformOptions, "github_actions_trust_policy_conditions")
	oidc_role_arn := terraform.Output(t, terraformOptions, "oidc_role")

	assert.Regexp(t, regexp.MustCompile(`^arn:aws:iam::\d{12}:oidc-provider/token.actions.githubusercontent.com`), github_actions_provider)

	//  Check that the GitHub OIDC statement exists in the output
	require.Contains(t, github_actions_role_trust_policy_conditions, `map[token.actions.githubusercontent.com:sub:[repo:ministryofjustice/modernisation-platform-environments:* repo:ministryofjustice/modernisation-platform-ami-builds:*]]`)

	// Check that the Malware Protection service statement exists in the output
	require.Contains(t, github_actions_role_trust_policy_conditions, `map[string_like:<nil>]`)

	// Testing backwards compatibility
	assert.Regexp(t, regexp.MustCompile(`^arn:aws:iam::\d{12}:role/github-actions`), oidc_role_arn)
}