# --- networking/outputs.tf ---

output "vpc_id" {
  value = aws_vpc.ad_vpc.id
}

output "public_sg" {
  value = aws_security_group.sg["public"].id
}

output "public_subnets" {
  value = aws_subnet.ad_public_subnet.*.id
}