terraform {
  cloud {
   
    organization = "your_organization"  # The name of your organization on Terraform Cloud.

    
    workspaces {
      name = "your_terraform_workspace" # The name of the Terraform workspace you are using within your organization.
    }
  }
}

terraform {
  required_providers {
    aws = {
      # The provider for AWS infrastructure.
      source  = "hashicorp/aws"
      # Specify the version constraint for the AWS provider.
      version = "~> 5.7.0"
    }
  }

  required_version = ">= 1.3"  # Specify the required version of Terraform itself.
}
