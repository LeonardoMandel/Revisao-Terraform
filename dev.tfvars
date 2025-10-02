aws_region          = "us-east-2"
environment         = "dev"

vpc_id              = "vpc-01367bb93348e0739" 
subnet_id           = "subnet-09391945fb2e0c6ae" 
security_group_name = "terram-dev-sg"

ami                       = "ami-0b016c703b95ecbe4"
cpu_cores                 = 1
cpu_threads_p_core        = 1
volume_size_root          = 10
volume_type_root          = "gp3"
volume_size_additional    = 20

ec2_instances = {
  "web-servidor-dev1" = {
    instance_type = "t3.micro"
  },
  "api-servidor-dev2" = {
    instance_type = "t3.small"
  }
}