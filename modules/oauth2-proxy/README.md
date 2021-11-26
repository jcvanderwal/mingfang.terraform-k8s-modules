
# Module `oauth2-proxy`

Provider Requirements:
* **k8s ([mingfang/k8s](https://registry.terraform.io/providers/mingfang/k8s/latest))** (any version)

## Input Variables
* `OAUTH2_PROXY_CLIENT_ID` (default `""`): client you have created
* `OAUTH2_PROXY_CLIENT_SECRET` (default `""`): your client's secret
* `OAUTH2_PROXY_COOKIE_DOMAINS` (default `""`)
* `OAUTH2_PROXY_COOKIE_SECRET` (required)
* `OAUTH2_PROXY_EMAIL_DOMAINS` (default `"*"`)
* `OAUTH2_PROXY_HTTP_ADDRESS` (default `"0.0.0.0:4180"`): make sure same as port
* `OAUTH2_PROXY_KEYCLOAK_GROUP` (default `""`): The group management in keycloak is using a tree. If you create a group named admin in keycloak you should define the ‘keycloak-group’ value to /admin.
* `OAUTH2_PROXY_LOGIN_URL` (default `""`): http(s)://<keycloak host>/realms/<your realm>/protocol/openid-connect/auth
* `OAUTH2_PROXY_PROVIDER` (required): keycloak
* `OAUTH2_PROXY_REDEEM_URL` (default `""`): http(s)://<keycloak host>/realms/<your realm>/protocol/openid-connect/token
* `OAUTH2_PROXY_REVERSE_PROXY` (default `true`): should always be true when using an ingress controller
* `OAUTH2_PROXY_SCOPE` (default `"email"`): must be set 'email' when provider is keycloak
* `OAUTH2_PROXY_SET_XAUTHREQUEST` (default `true`): sends headers using this ingress annotation: "nginx.ingress.kubernetes.io/auth-response-headers" = "X-Auth-Request-User, X-Auth-Request-Email"
* `OAUTH2_PROXY_VALIDATE_URL` (default `""`): http(s)://<keycloak host>/realms/<your realm>/protocol/openid-connect/userinfo
* `OAUTH2_PROXY_WHITELIST_DOMAINS` (default `""`)
* `annotations` (default `{}`)
* `env` (default `[]`)
* `image` (default `"quay.io/oauth2-proxy/oauth2-proxy:v6.1.1"`)
* `name` (required)
* `namespace` (required)
* `overrides` (default `{}`)
* `ports` (default `[{"name":"http","port":4180}]`)
* `replicas` (default `1`)

## Output Values
* `deployment`
* `name`
* `ports`
* `service`

## Child Modules
* `deployment-service` from [../../archetypes/deployment-service](../../archetypes/deployment-service)

