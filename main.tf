module "ec2_instances" {
  source = "./modules/ec2"

  aws_region          = var.aws_region
  environment         = var.environment
  vpc_id              = var.vpc_id
  subnet_id           = var.subnet_id
  security_group_name = var.security_group_name
  ami                 = var.ami
  ec2_instances       = var.ec2_instances
  cpu_cores           = var.cpu_cores
  cpu_threads_p_core  = var.cpu_threads_p_core
  volume_size_root    = var.volume_size_root
  volume_type_root    = var.volume_type_root
  volume_size_additional = var.volume_size_additional
}