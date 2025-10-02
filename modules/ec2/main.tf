# Define o Security Group para as instâncias
resource "aws_security_group" "instancia_sg" {
  name        = var.security_group_name
  description = "Grupo de seguranca gerenciado pelo Terraform para o ambiente ${var.environment}"
  vpc_id      = var.vpc_id

  # Regra de entrada para HTTP
  ingress {
    description = "Permitir trafego HTTP da internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Regra de saida para qualquer trafego
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Cria as instâncias EC2 usando um loop (for_each)
resource "aws_instance" "servidores" {
  for_each = var.ec2_instances

  ami                         = var.ami
  instance_type               = each.value.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.instancia_sg.id]
  associate_public_ip_address = true
  
  # user_data para instalar o Apache e montar o volume adicional
  user_data                   = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Provisionado via Terraform. Olá Mundo!</h1>" > /var/www/html/index.html
              mkfs -t xfs /dev/sdh
              mkdir /novo-disco
              mount /dev/sdh /novo-disco
              echo "/dev/sdh /novo-disco xfs defaults,nofail 0 2" >> /etc/fstab
              EOF

  # Configuracao de CPU (cores e threads)
  cpu_options {
    core_count       = var.cpu_cores
    threads_per_core = var.cpu_threads_p_core
  }

  # Configuracao do disco raiz (root_block_device)
  root_block_device {
    volume_size = var.volume_size_root
    volume_type = var.volume_type_root
  }

  # Adiciona tags para identificacao
  tags = {
    Name        = "servidor-${each.key}-${var.environment}"
    Ambiente    = var.environment
    ManagedBy   = "Terraform"
  }
}

# Cria os volumes EBS adicionais
resource "aws_ebs_volume" "discos_adicionais" {
  for_each          = var.ec2_instances
  availability_zone = aws_instance.servidores[each.key].availability_zone
  size              = var.volume_size_additional

  tags = {
    Name = "disco-adicional-${each.key}"
  }
}

# Anexa os volumes as instancias
resource "aws_volume_attachment" "anexar_volumes" {
  for_each    = var.ec2_instances
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.discos_adicionais[each.key].id
  instance_id = aws_instance.servidores[each.key].id
}