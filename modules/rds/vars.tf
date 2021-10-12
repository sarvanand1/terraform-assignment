variable "allocated_storage" {
  default = 10
}

variable "region" {
  default = "us-east-1"
}

variable "engine" {
  default = "postgres"
}

variable "storage_type" {
  default = "gp2"
}

variable "instance_class" {
  default = "db.t3.micro"
}

variable "name" {
  default = "my_postgres_database"
}

variable "username" {
  default = "Rock"
}

variable "password" {
  default = "rock1234444"
}

variable "db_subnet_group_name" {
  description = "DB instance will be created in the VPC associated with the DB subnet group."
}

variable "skip_final_snapshot" {
  default = "true"
}

variable "vpc_security_group_id_for_ec2" {
  description = "Security group for EC2 instance"
}

variable "identifier" {
  default = "my-postgres-database"

}

