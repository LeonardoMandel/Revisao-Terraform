# Variaveis de rede
variable "aws_region" {
  description = "Regiao da AWS onde a infraestrutura sera provisionada."
  type        = string
}

variable "environment" {
  description = "Ambiente de deployment (ex: dev, prod)."
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC principal para o deployment."
  type        = string
}

variable "subnet_id" {
  description = "ID da subnet para as instancias."
  type        = string
}

variable "security_group_name" {
  description = "Nome do Security Group."
  type        = string
}


# Variaveis da EC2
variable "ami" {
  description = "AMI ID da imagem de maquina para as instancias."
  type        = string
}

variable "ec2_instances" {
  description = "Mapa que define as instancias a serem criadas (nome e tipo)."
  type = map(object({
    instance_type = string
  }))
}


# Variaveis de configuracao de CPU
variable "cpu_cores" {
  description = "Numero de cores de CPU."
  type        = number
  default     = 1
}

variable "cpu_threads_p_core" {
  description = "Numero de threads por core."
  type        = number
  default     = 1
}


# Variaveis de configuracao de volumes
variable "volume_size_root" {
  description = "Tamanho do disco raiz em GB."
  type        = number
  default     = 8
}

variable "volume_type_root" {
  description = "Tipo de disco raiz (ex: gp3, gp2, io1)."
  type        = string
  default     = "gp3"
}

variable "volume_size_additional" {
  description = "Tamanho do disco adicional em GB."
  type        = number
  default     = 10
}