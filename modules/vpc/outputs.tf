output "subnet_id_for_ec2" {
  value = aws_subnet.public_subnet.*.id
}

output "vpc_security_group_id_for_ec2" {
  value = aws_security_group.allow_tls.id
}

output "db_subnet_group" {
  value = aws_db_subnet_group.db_subnet_group.name
}
