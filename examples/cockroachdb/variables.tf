variable "name" {
  default = "cockroachdb"
}

variable "namespace" {
  default = "cockroachdb-example"
}

variable "replicas" {
  default = 4
}

variable "storage" {
  default = "1Gi"
}

variable "storage_class" {
  default = null //use default
}