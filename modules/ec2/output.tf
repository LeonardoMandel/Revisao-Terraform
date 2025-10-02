output "ips_publicos_instancias" {
  description = "Mapa com os nomes das instancias e seus IPs publicos."
  value = {
    for nome, instancia in aws_instance.servidores : nome => instancia.public_ip
  }
}

output "ips_privados_instancias" {
  description = "Mapa com os nomes das instancias e seus IPs privados."
  value = {
    for nome, instancia in aws_instance.servidores : nome => instancia.private_ip
  }
}