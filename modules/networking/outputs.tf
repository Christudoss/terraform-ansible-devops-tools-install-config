output "vpc_id" {
  value = aws_vpc.devops.id
}

output "subnet_id" {
  value = aws_subnet.subnet.*.id
}