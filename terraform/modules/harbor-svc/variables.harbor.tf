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

variable "harbor_admin_username" {
  type                             = string
  sensitive                        = true
  default                          = "admin"
}

variable "harbor_admin_password" {
  type                             = string
  sensitive                        = true
}
