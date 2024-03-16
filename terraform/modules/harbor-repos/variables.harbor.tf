variable "harbor_http_endpoint" {
  type                             = string
  description                      = "Base url for where the harbor instance is hosted at."
  default                          = "https://harbor.titania.adrp.xyz"
}

variable "harbor_http_endpoint_insecure" {
  type                             = bool
  description                      = "Wether to check the ssl certs for the tls connection"
  default                          = true
}

variable "harbor_proxy" {
  type                             = map(object({
    url                            = string
    provider                       = optional(string, "docker-registry")
    insecure                       = optional(bool, false)
    enabled                        = optional(bool, true)
  }))
  description                      = "List of harbor registry to create proxies for."
  default                          = { }
}

variable "harbor_proxy_view" {
  type                             = bool
  description                      = "Wether to make the remote viewable without auth"
  default                          = true
}

variable "harbor_proxy_delete" {
  type                             = bool
  description                      = "Wether to make the remote deleteable without clearing out the images first"
  default                          = true
}
