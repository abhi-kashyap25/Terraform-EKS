# Terraform-EKS
This repository contains Terraform scripts to deploy an Amazon EKS (Elastic Kubernetes Service) cluster on AWS. 
# Features
Infrastructure as Code: Define your AWS infrastructure using Terraform configuration files.

EKS Cluster Deployment: Provision an EKS cluster with specified configurations.

IAM Role and Policies: Automatically create IAM roles and policies for EKS cluster and worker nodes.

Networking Configuration: Configure VPC, subnets, and security groups for the EKS cluster.

# Steps Involved in the Process

### 1.Install AWS CLI 

As the first step, you'll need to install the AWS CLI. We'll use the aws configure command to connect Terraform with AWS in the next steps.

Follow the link below to install AWS CLI:
```
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
```

### 2.Install Terraform

Next, Install Terraform using the below link.
```
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
```

Connect Terraform with AWS
Connecting Terraform with AWS is straightforward. Simply run the aws configure command and provide your AWS security credentials as shown in the video or guide.

### 3.Set Up AWS Credentials:

Make sure you have your AWS access key ID and secret access key configured. You can set them as environment variables or use the AWS CLI to configure them.
Clone the Repository:

### 4.Clone this repository to your local machine using the command:
```
git clone <repository_url>
```
### 5.Update Variables:

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

