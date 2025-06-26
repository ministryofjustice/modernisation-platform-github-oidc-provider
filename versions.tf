terraform {
  required_providers {
    aws = {
      version = "~> 6.1"
      source  = "hashicorp/aws"
    }
    tls = {
      version = "~> 4.0"
      source  = "hashicorp/tls"
    }
  }
  required_version = ">= 1.0.1"
}
