package main

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"regexp"
	"testing"
)

func TestGitHubOIDCProviderCreation(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "./unit-test",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	github_actions_provider := terraform.Output(t, terraformOptions, "github_actions_provider")

	assert.Regexp(t, regexp.MustCompile(`^example-name*`), github_actions_provider)
}
