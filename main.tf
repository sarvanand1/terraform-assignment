module "vpc" {
  source = ".//modules/vpc"
}


module "ec2_instance" {
  source                        = ".//modules/ec2_instance"
  vpc_security_group_id_for_ec2 = module.vpc.vpc_security_group_id_for_ec2
  subnet_id_for_ec2             = module.vpc.subnet_id_for_ec2
}

module "dataset" {
  source                        = ".//modules/rds"
  db_subnet_group_name          = module.vpc.db_subnet_group
  vpc_security_group_id_for_ec2 = module.vpc.vpc_security_group_id_for_ec2
}
