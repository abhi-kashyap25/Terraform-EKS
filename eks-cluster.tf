# Define EKS cluster using the terraform-aws-modules/eks/aws module.

module "eks" {
    source  = "terraform-aws-modules/eks/aws" # Source module for EKS.
    version = "20.8.4" # Version of the EKS module.

    # Cluster name and version.
    cluster_name    = local.cluster_name # Name of the EKS cluster.
    cluster_version = var.kubernetes_version # Kubernetes version for the EKS cluster.

    # VPC configuration and subnet IDs for the EKS cluster.
    vpc_id                         = module.vpc.vpc_id # VPC ID from the VPC module.
    subnet_ids                     = module.vpc.private_subnets # Subnets from the VPC module.
    cluster_endpoint_public_access = true # Allow public access to the EKS cluster.

    # Enable IAM roles for service accounts (IRSA) support.
    enable_irsa = true

    # Defaults for EKS managed node groups.
    eks_managed_node_group_defaults = {
        ami_type = "AL2_x86_64" # Amazon Linux 2 image for the node group.
    }

    # Define managed node groups with instance types, sizes, and desired state.
    eks_managed_node_groups = {
        one = {
            name          = "node-group-1" # Name of the first node group.
            instance_types = ["t3.small"] # EC2 instance type for the node group.
            min_size      = 1 # Minimum number of instances in the node group.
            max_size      = 3 # Maximum number of instances in the node group.
            desired_size  = 2 # Desired number of instances in the node group.
        }

        two = {
            name          = "node-group-2" # Name of the second node group.
            instance_types = ["t3.small"] # EC2 instance type for the node group.
            min_size      = 1 # Minimum number of instances in the node group.
            max_size      = 2 # Maximum number of instances in the node group.
            desired_size  = 1 # Desired number of instances in the node group.
        }
    }
}

# Define AWS IAM policy data for the Amazon EBS CSI driver.
# This policy is used to grant permissions to the EBS CSI driver.
data "aws_iam_policy" "ebs_csi_policy" {
    arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy" # ARN of the EBS CSI driver policy.
}

# Define an IAM role for IRSA with OIDC for the EBS CSI driver.
module "irsa-ebs-csi" {
    source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc" # Source module for IAM with OIDC.
    version = "4.7.0" # Version of the IAM module.

    create_role                   = true # Create a new IAM role.
    role_name                     = "AmazonEKSTFEBSCSIRole-${module.eks.cluster_name}" # IAM role name.
    provider_url                  = module.eks.oidc_provider # OIDC provider URL.
    role_policy_arns              = [data.aws_iam_policy.ebs_csi_policy.arn] # ARN of the EBS CSI driver policy.
    oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"] # OIDC subjects for the role.
}

# Define the AWS EKS add-on for the EBS CSI driver.
# This resource provisions the EBS CSI driver as an add-on for the EKS cluster.
resource "aws_eks_addon" "ebs-csi" {
    cluster_name             = module.eks.cluster_name # Name of the EKS cluster.
    addon_name               = "aws-ebs-csi-driver" # Name of the add-on.
    addon_version            = "v1.20.0-eksbuild.1" # Version of the add-on.
    service_account_role_arn = module.irsa-ebs-csi.iam_role_arn # ARN of the IAM role for the add-on.
    tags = {
        "eks_addon" = "ebs-csi" # Tag for the EKS add-on.
        "terraform" = "true" # Tag indicating the resource was provisioned with Terraform.
    }
}
