output "vpc_id" {
  description = "ID of the VPC."
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "Public subnet IDs keyed by subnet index."
  value       = { for k, v in aws_subnet.public : k => v.id }
}

output "private_subnet_ids" {
  description = "Private subnet IDs keyed by subnet index."
  value       = { for k, v in aws_subnet.private : k => v.id }
}

output "internet_gateway_id" {
  description = "Internet gateway ID."
  value       = aws_internet_gateway.this.id
}

output "nat_gateway_ids" {
  description = "NAT gateway IDs. Empty when NAT is disabled."
  value       = aws_nat_gateway.this[*].id
}

output "public_route_table_id" {
  description = "Public route table ID."
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "Private route table IDs keyed by subnet index."
  value       = { for k, v in aws_route_table.private : k => v.id }
}

output "vpc_flow_log_id" {
  description = "VPC Flow Log ID when enabled."
  value       = try(aws_flow_log.vpc[0].id, null)
}
