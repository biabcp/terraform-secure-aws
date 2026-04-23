variable "name" {
  description = "Name prefix for all resources."
  type        = string

  validation {
    condition     = length(var.name) > 2
    error_message = "name must be at least 3 characters long."
  }
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones used for subnet placement."
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) > 0
    error_message = "At least one availability zone is required."
  }
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets. One per availability zone."
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_cidrs) == length(var.availability_zones)
    error_message = "public_subnet_cidrs length must match availability_zones length."
  }
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets. One per availability zone."
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_cidrs) == length(var.availability_zones)
    error_message = "private_subnet_cidrs length must match availability_zones length."
  }
}

variable "enable_nat_gateway" {
  description = "Creates NAT gateways and private default routes for outbound internet egress."
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Use a single NAT gateway for all private subnets (lower cost, lower AZ resiliency)."
  type        = bool
  default     = true
}

variable "enable_vpc_flow_logs" {
  description = "Enable VPC Flow Logs to CloudWatch Logs."
  type        = bool
  default     = true
}

variable "vpc_flow_logs_retention_days" {
  description = "Retention period in days for VPC Flow Logs."
  type        = number
  default     = 90
}

variable "vpc_flow_logs_traffic_type" {
  description = "Type of traffic to capture in VPC Flow Logs: ACCEPT, REJECT, or ALL."
  type        = string
  default     = "ALL"

  validation {
    condition     = contains(["ACCEPT", "REJECT", "ALL"], var.vpc_flow_logs_traffic_type)
    error_message = "vpc_flow_logs_traffic_type must be one of ACCEPT, REJECT, or ALL."
  }
}

variable "vpc_flow_logs_kms_key_id" {
  description = "Optional KMS key ARN to encrypt the VPC Flow Logs log group."
  type        = string
  default     = null
}

variable "tags" {
  description = "Common tags to apply to all resources."
  type        = map(string)
  default     = {}
}
