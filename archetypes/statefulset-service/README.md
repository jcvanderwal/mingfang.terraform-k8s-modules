
# Module `statefulset-service`

Provider Requirements:
* **k8s ([mingfang/k8s](https://registry.terraform.io/providers/mingfang/k8s/latest))** (any version)

## Input Variables
* `parameters` (default `null`)
* `podAnnotations` (default `{}`)

## Output Values
* `labels`
* `name`
* `service`
* `statefulset`

## Managed Resources
* `k8s_apps_v1_stateful_set.this` from `k8s`
* `k8s_core_v1_service.this` from `k8s`
* `k8s_core_v1_service.this-srv` from `k8s`

