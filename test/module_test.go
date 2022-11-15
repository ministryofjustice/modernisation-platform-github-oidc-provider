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

	terraform.Init(t, terraformOptions)
	terraform.WorkspaceSelectOrNew(t, terraformOptions, "testing-test")

	terraform.Apply(t, terraformOptions)

	github_actions_provider := terraform.Output(t, terraformOptions, "github_actions_provider")
	github_actions_role_trust_policy_conditions := terraform.Output(t, terraformOptions, "github_actions_trust_policy_conditions")

	assert.Regexp(t, regexp.MustCompile(`^arn:aws:iam::\d{12}:oidc-provider/token.actions.githubusercontent.com`), github_actions_provider)
	require.Equal(t, github_actions_role_trust_policy_conditions, "[map[token.actions.githubusercontent.com:sub:[repo:ministryofjustice/modernisation-platform-environments:* repo:ministryofjustice/modernisation-platform-ami-builds:*]]]")
}
