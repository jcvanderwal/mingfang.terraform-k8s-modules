locals {
  parameters = {
    name      = var.name
    namespace = var.namespace
    // restart on config change
    annotations = merge(var.annotations, { checksum = module.config.checksum })

    containers = [
      {
        name  = "agent"
        image = var.image
        args = [
          "-config.file=/etc/agent/agent.yaml",
        ]
        env = concat([
          {
            name = "HOSTNAME"
            value_from = {
              field_ref = {
                field_path = "spec.nodeName"
              }
            }
          },
        ], var.env)

        resources = var.resources

        security_context = {
          capabilities = {
            add = ["SYS_TIME"]
          }
        }

        volume_mounts = [
          {
            name       = "config"
            mount_path = "/etc/agent"
          },
          {
            name       = "rootfs"
            mount_path = "/host"
            read_only  = true
          }
        ]
      },
    ]
    service_account_name = module.rbac.service_account.metadata.0.name
    volumes = [
      {
        name = "config"
        config_map = {
          name = module.config.name
        }
      },
      {
        name = "rootfs"
        host_path = {
          path = "/"
        }
      }
    ]
  }
}

module "config" {
  source    = "../../kubernetes/config-map"
  name      = var.name
  namespace = var.namespace

  from-map = {
    "agent.yaml" = templatefile(coalesce(var.config_file, "${path.module}/agent.yaml"), {
      remote_write_url = var.remote_write_url
      wal_directory    = "/tmp/agent/data"
      log_level        = var.log_level
    })
  }
}

module "daemonset" {
  source     = "../../../archetypes/daemonset"
  parameters = merge(local.parameters, var.overrides)
}