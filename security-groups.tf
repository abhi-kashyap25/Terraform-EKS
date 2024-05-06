# Define the security group for worker management in the specified VPC
resource "aws_security_group" "all_worker_mgmt" {
  name_prefix = "all_worker_management"
  vpc_id      = var.vpc_id  # Using variable for flexibility

  # Adding tags for better organization and tracking
  tags = {
    Name        = "all_worker_management"
    Environment = var.environment  # Use variable to specify the environment (e.g. prod, dev)
  }
}

# Ingress rule to allow traffic from specific private IP ranges
resource "aws_security_group_rule" "all_worker_mgmt_ingress" {
  description       = "Allow inbound traffic from EKS"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"  # All protocols
  security_group_id = aws_security_group.all_worker_mgmt.id
  type              = "ingress"

  # Use variable for CIDR blocks to make the rule more customizable
  cidr_blocks = var.allowed_cidr_blocks
}

# Egress rule to allow outbound traffic to any IP address
resource "aws_security_group_rule" "all_worker_mgmt_egress" {
  description       = "Allow outbound traffic to anywhere"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"  # All protocols
  security_group_id = aws_security_group.all_worker_mgmt.id
  type              = "egress"

  # Allow all IP addresses for outbound traffic
  cidr_blocks = ["0.0.0.0/0"]
}
