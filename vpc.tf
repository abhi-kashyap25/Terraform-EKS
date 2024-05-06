
data "aws_availability_zones" "available" {}

locals {
  cluster_name = "your-eks-${random_string.suffix.result}" # The name of the EKS cluster with a randomly generated suffix.
}

# Generates an 8-character long random string to use as a suffix for resource names.
resource "random_string" "suffix" {
  length  = 8 # Length of the random string.
  special = false # No special characters in the random string.
}

# VPC Module Configuration:
# This block uses the terraform-aws-modules/vpc/aws module to create a VPC for the EKS cluster.
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws" # Source module for VPC.
  version = "5.0.0" # Version of the VPC module.

  name = "eks-vpc" # Name of the VPC.

  # Define the CIDR block for the VPC.
  cidr = "10.0.0.0/16"

  # Use the first three availability zones from the fetched data source.
  azs  = slice(data.aws_availability_zones.available.names, 0, 3)

  # Define private and public subnets within the VPC.
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  # Enable and configure NAT gateways within the VPC.
  enable_nat_gateway   = true # Enable NAT gateways.s
  single_nat_gateway   = true # Use a single NAT gateway.

  # Enable DNS hostnames for the VPC.
  enable_dns_hostnames = true

  # Tags for public subnets to specify Kubernetes usage.
  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = 1
  }

  # Tags for private subnets to specify Kubernetes usage.
  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = 1
  }
}
