package main

import (
	"regexp"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
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

	assert.Regexp(t, regexp.MustCompile(`^arn:aws:iam::\d{12}:oidc-provider/token.actions.githubusercontent.com`), github_actions_provider)
}
