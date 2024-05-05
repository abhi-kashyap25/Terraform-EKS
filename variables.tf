# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
  
}

variable "access_key" {
  description = "value for access key"
  
}

variable "secret_key" {
  description = "value for secret_key"
  
}

variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed for inbound traffic"
  type        = list(string)
  default     = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
}

variable "environment" {
  description = "The deployment environment"
  default     = "dev"  # Set the default to 'dev' or another desired environment
}
