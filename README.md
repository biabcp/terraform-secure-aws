# terraform-secure-aws

A production-focused Terraform AWS network baseline that creates a hardened VPC layout with:

- Public and private subnets across multiple Availability Zones.
- Optional NAT gateway architecture for private subnet egress.
- Default security group lockdown (no implicit ingress/egress rules).
- Optional VPC Flow Logs with CloudWatch retention controls.
- Tagging and naming conventions for operational consistency.

## Module inputs

| Name | Type | Default | Description |
| --- | --- | --- | --- |
| `name` | `string` | n/a | Name prefix for all resources. |
| `vpc_cidr` | `string` | n/a | CIDR block for the VPC. |
| `availability_zones` | `list(string)` | n/a | AZs used for subnet placement. |
| `public_subnet_cidrs` | `list(string)` | n/a | Public subnet CIDRs (must match AZ count). |
| `private_subnet_cidrs` | `list(string)` | n/a | Private subnet CIDRs (must match AZ count). |
| `enable_nat_gateway` | `bool` | `true` | Enables NAT gateways and private default routes. |
| `single_nat_gateway` | `bool` | `true` | One shared NAT gateway (cost-optimized) when `true`; one per AZ when `false`. |
| `enable_vpc_flow_logs` | `bool` | `true` | Enables VPC Flow Logs to CloudWatch Logs. |
| `vpc_flow_logs_retention_days` | `number` | `90` | Retention days for flow logs. |
| `vpc_flow_logs_traffic_type` | `string` | `"ALL"` | One of `ACCEPT`, `REJECT`, `ALL`. |
| `vpc_flow_logs_kms_key_id` | `string` | `null` | Optional KMS key ARN for CloudWatch log encryption. |
| `tags` | `map(string)` | `{}` | Common tags for all resources. |

## Module outputs

- `vpc_id`
- `public_subnet_ids`
- `private_subnet_ids`
- `internet_gateway_id`
- `nat_gateway_ids`
- `public_route_table_id`
- `private_route_table_ids`
- `vpc_flow_log_id`

## Example

```hcl
module "network" {
  source = "./terraform-secure-aws"

  name               = "prod-core"
  vpc_cidr           = "10.20.0.0/16"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

  public_subnet_cidrs  = ["10.20.0.0/24", "10.20.1.0/24", "10.20.2.0/24"]
  private_subnet_cidrs = ["10.20.10.0/24", "10.20.11.0/24", "10.20.12.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = false
  enable_vpc_flow_logs = true

  tags = {
    Environment = "production"
    Owner       = "platform"
    CostCenter  = "infra"
  }
}
```

## Production guidance

- Use at least 2 AZs, preferably 3 for regional resilience.
- Set `single_nat_gateway = false` for higher availability and AZ fault tolerance.
- Provide a customer-managed KMS key via `vpc_flow_logs_kms_key_id` for stricter encryption controls.
- Add SCPs, IAM boundaries, and workload-specific security groups in the root stack that consumes this module.
- Pin provider versions in your root module and run `terraform plan` in CI for every change.

## Quick start

```bash
terraform init
terraform fmt -check
terraform validate
terraform plan
```
