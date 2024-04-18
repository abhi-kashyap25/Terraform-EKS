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