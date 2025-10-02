aws_region          = "us-east-2"
environment         = "prod"

vpc_id              = "vpc-01367bb93348e0739" 
subnet_id           = "subnet-09391945fb2e0c6ae" 
security_group_name = "terram-prod=sg"

ami                       = "ami-0b016c703b95ecbe4"
cpu_cores                 = 2
cpu_threads_p_core        = 1
volume_size_root          = 10
volume_type_root          = "gp3"
volume_size_additional    = 50

ec2_instances = {
  "web-servidor-prod1" = {
    instance_type = "t3.nano"
  },
  "api-servidor-prod2" = {
    instance_type = "t3.small"
  }
}