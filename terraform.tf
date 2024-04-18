terraform {
  cloud {
    organization = "abhi_kashyap_25"

    workspaces {
      name = "learn-terraform-eks"
    }
  }
}
  
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.7.0"
    }
  }

  required_version = ">= 1.3"
}


