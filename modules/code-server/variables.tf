variable "name" {
  type    = string
  default = "code-server"
}

variable "namespace" {
  type = string
}

variable "image" {
  type    = string
  default = "codercom/code-server:latest"
}

variable "replicas" {
  type    = number
  default = 1
}

variable "ports" {
  type    = list
  default = [{ name = "tcp", port = 8080 }]
}

variable "command" {
  type    = list(string)
  default = []
}

variable "args" {
  type    = list(string)
  default = []
}

variable "env" {
  type    = list(object({ name = string, value = string }))
  default = []
}

variable "env_map" {
  type    = map
  default = {}
}

variable "env_file" {
  type    = string
  default = null
}

variable "env_from" {
  type = list(object({
    prefix = string,
    secret_ref = object({
      name = string,
    })
  }))
  default = []
}

variable "annotations" {
  type    = map
  default = {}
}

variable "image_pull_secrets" {
  type    = list(object({ name = string, value = string }))
  default = []
}

variable "node_selector" {
  default = {}
}

variable "resources" {
  default = {
    requests = {
      cpu    = "250m"
      memory = "64Mi"
    }
  }
}


variable "service_account_name" {
  type    = string
  default = null
}


variable "overrides" {
  default = {}
}

variable "configmap" {
  default = null
}

variable "configmap_mount_path" {
  type    = string
  default = "/config"
}

variable "post_start_command" {
  type    = list(string)
  default = null
}

variable "pvcs" {
  type = list(object({
    name       = string
    mount_path = string
  }))
  default = []
}

variable "pvc_user" {
  type    = string
  default = "1000"
}

variable "volumes" {
  type = list(object({
    name       = string
    empty_dir  = object({})
    mount_path = string
  }))
  default = []
}

variable "sidecars" {
  default = []
}

variable "storage" {
  type    = string
  default = null
}

variable "storage_class" {
  type    = string
  default = null
}

variable "volume_claim_template_name" {
  type    = string
  default = "pvc"
}

variable "mount_path" {
  type        = string
  default     = "/data"
  description = "pvc mount path"
}

