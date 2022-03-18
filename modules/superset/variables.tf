variable "name" {}

variable "namespace" {}

variable "image" {
  default = "apache/superset"
}

variable "replicas" {
  default = 1
}

variable ports {
  default = [
    {
      name = "http"
      port = 8088
    },
  ]
}

variable "command" {
  default     = null
  description = "Override the default command to run as worker. e.g.  or celery --app=superset.tasks.celery_app:app worker"
}

variable "env" {
  default = []
}

variable "annotations" {
  default = {}
}

variable "overrides" {
  default = {}
}

variable "config_configmap" {
  default = null
}
