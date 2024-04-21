# Terraform Cloud Configuration:
# This block specifies the configuration for using Terraform Cloud.
terraform {
  cloud {
    # The name of your organization on Terraform Cloud.
    organization = "your_organization"

    # The name of the Terraform workspace you are using within your organization.
    workspaces {
      name = "your_terraform_workspace"
    }
  }
}

# Terraform Configuration:
# This block specifies the requirements for Terraform, including the providers and versions.
terraform {
  # Specify the required providers and their versions.
  required_providers {
    aws = {
      # The provider for AWS infrastructure.
      source  = "hashicorp/aws"
      # Specify the version constraint for the AWS provider.
      version = "~> 5.7.0"
    }
  }

  # Specify the required version of Terraform itself.
  required_version = ">= 1.3"
}
