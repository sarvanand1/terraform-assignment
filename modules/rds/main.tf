resource "aws_db_instance" "rds" {
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  storage_type           = var.storage_type
  instance_class         = var.instance_class
  name                   = var.name
  username               = var.username
  password               = var.password
  db_subnet_group_name   = var.db_subnet_group_name
  skip_final_snapshot    = var.skip_final_snapshot
  identifier             = var.identifier
  vpc_security_group_ids = [var.vpc_security_group_id_for_ec2]
}
