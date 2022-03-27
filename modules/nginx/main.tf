locals {
  parameters = {
    name                 = var.name
    namespace            = var.namespace
    replicas             = var.replicas
    ports                = var.ports
    enable_service_links = false

    annotations = merge(
      var.annotations,
      var.default-conf != null || var.nginx-conf != null ? {
        "config_checksum" = md5(join("", keys(k8s_core_v1_config_map.this.0.data), values(k8s_core_v1_config_map.this.0.data)))
      } : {},
    )

    containers = [
      {
        name  = "nginx"
        image = var.image

        env = concat([
          {
            name = "POD_NAME"

            value_from = {
              field_ref = {
                field_path = "metadata.name"
              }
            }
          },
        ], var.env)

        volume_mounts = concat(
          var.nginx-conf != null ? [
            {
              name       = "config"
              mount_path = "/etc/nginx/nginx.conf"
              sub_path   = "nginx.conf"
            },
          ] : [],
          var.default-conf != null ? [
            {
              name       = "config"
              mount_path = "/etc/nginx/conf.d/default.conf"
              sub_path   = "default.conf"
            },
          ] : [],
        )
      }
    ]

    volumes = var.nginx-conf != null || var.default-conf != null ? [
      {
        config_map = {
          name = var.name
        }
        name = "config"
      },
    ] : []
  }
}

module "deployment-service" {
  source     = "../../archetypes/deployment-service"
  parameters = merge(local.parameters, var.overrides)
}