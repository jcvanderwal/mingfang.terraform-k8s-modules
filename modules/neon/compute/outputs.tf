output "name" {
  value = var.name
}

output "image" {
  value = var.image
}

output "ports" {
  value = var.ports
}

output "service" {
  value = module.deployment-service.service
}

output "deployment" {
  value = module.deployment-service.deployment
}
