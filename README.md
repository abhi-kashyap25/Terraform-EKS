# Terraform-EKS
This repository contains Terraform scripts to deploy an Amazon EKS (Elastic Kubernetes Service) cluster on AWS. 
# Features
Infrastructure as Code: Define your AWS infrastructure using Terraform configuration files.

EKS Cluster Deployment: Provision an EKS cluster with specified configurations.

IAM Role and Policies: Automatically create IAM roles and policies for EKS cluster and worker nodes.

Networking Configuration: Configure VPC, subnets, and security groups for the EKS cluster.

# Steps Involved in the Process

### Set Up AWS Credentials:

Make sure you have your AWS access key ID and secret access key configured. You can set them as environment variables or use the AWS CLI to configure them.
Clone the Repository:

Clone this repository to your local machine using the command:
bash
Copy code
```
git clone <repository_url>
```
Update Variables:

Open the variables.tf file in a text editor.
Update the variables to match your desired configuration. You can specify details such as the AWS region, EKS cluster name, instance type for worker nodes, etc.
Initialize Terraform:

Open a terminal or command prompt.
Navigate to the directory where you cloned the repository.
Run the following command to initialize Terraform:
csharp
```
terraform init
```
Plan and Apply Changes:

After initialization, run the following command to see the execution plan:
```
terraform plan
```

Review the plan to ensure it matches your expectations.
If the plan looks good, apply the changes by running:
```
terraform apply
```
Access the EKS Cluster:

Once Terraform has finished applying changes, it will generate a kubeconfig file.
Use the generated kubeconfig file to access your EKS cluster and manage Kubernetes resources.
