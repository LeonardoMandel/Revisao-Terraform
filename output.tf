output "ips_publicos_instancias" {
  description = "Mapa com os nomes das instancias e seus IPs publicos."
  value = module.ec2_instances.ips_publicos_instancias
}

output "ips_privados_instancias" {
  description = "Mapa com os nomes das instancias e seus IPs privados."
  value = module.ec2_instances.ips_privados_instancias
}