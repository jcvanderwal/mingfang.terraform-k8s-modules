variable "name" {}

variable "namespace" {}

variable "replicas" {
  default = 1
}

variable "image" {
  default = "stackstorm/st2notifier:latest"
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

variable "config_map" {}
