variable "name" {}

variable "namespace" {}

variable "image" {
  default = "apache/superset"
}

variable "replicas" {
  default = 1
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

variable "type" {
  default     = "worker"
  description = "worker or beat"
}
