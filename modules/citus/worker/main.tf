locals {
  parameters = {
    name                        = var.name
    namespace                   = var.namespace
    annotations                 = var.annotations
    replicas                    = var.replicas
    ports                       = var.ports
    enable_service_links        = false
    pod_management_policy       = "Parallel"
    publish_not_ready_addresses = true

    containers = [
      {
        name  = "worker"
        image = var.image

        env = concat([
          {
            name = "HOSTNAME"

            value_from = {
              field_ref = {
                field_path = "metadata.name"
              }
            }
          },
          {
            name = "POD_IP"

            value_from = {
              field_ref = {
                field_path = "status.podIP"
              }
            }
          },
          {
            name = "PGDATA"
            value = "/data"
          },
          {
            name: "PGPASSWORD"
            value_from ={
              secret_key_ref = {
                name: var.secret
                key: "password"
              }

            }
          },
          {
            name: "POSTGRES_PASSWORD"
            value_from ={
              secret_key_ref = {
                name: var.secret
                key: "password"
              }

            }
          },
        ], var.env)

        resources = var.resources

        liveness_probe = {
          exec = {
            command = [
              "./pg_healthcheck"
            ]
            initial_delay_seconds: 60

          }

        }

        lifecycle = {
          post_start = {
            exec = {
              command = [
                "sh",
                "-cx",
                <<-EOF
                sleep 10
                psql \
                  --host=${var.coordinator} \
                  --username=postgres \
                  --command="SELECT * from master_add_node('$${HOSTNAME}.${var.name}.${var.namespace}.svc.cluster.local', ${var.ports[0].port});"
                EOF
              ]
            }
          }
        }

        volume_mounts = [
          {
            name       = var.volume_claim_template_name
            mount_path = "/data"
          },
          {
            name       = "shm"
            mount_path = "/dev/shm"
          },
        ]
      },
    ]

    volumes = [
      {
        name = "shm"

        empty_dir = {
          "medium" = "Memory"
        }
      },
    ]

    volume_claim_templates = [
      {
        name               = var.volume_claim_template_name
        storage_class_name = var.storage_class
        access_modes       = ["ReadWriteOnce"]

        resources = {
          requests = {
            storage = var.storage
          }
        }
      }
    ]
  }
}

module "statefulset-service" {
  source     = "../../../archetypes/statefulset-service"
  parameters = merge(local.parameters, var.overrides)
}