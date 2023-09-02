variable "zones" {
  type                             = map(object({
    kind                           = optional(string, "Native")
    soa_edit_api                   = optional(string, null)
    nameservers                    = optional(list(string), [ "10.3.10.5.", "10.3.10.6." ])
  }))
  description                      = "List of domain zones to create."
  default                          = { }
}

variable "subzones" {
  type                             = map(object({
    soa_edit_api                   = optional(string, null)
    masters                        = optional(list(string), [ "10.3.10.5", "10.3.10.6" ])
  }))
  description                      = "List of subdomain zones to create."
  default                          = { }
}

variable "records" {
  type                             = map(object({
    zone                           = string
    type                           = optional(string, "A")
    record                         = list(string)
    ttl                            = optional(number, 300)
    set_ptr                        = optional(bool, true)
  }))
  description                      = "List of records to create."
  default                          = { }
}

variable "matchbox_http_endpoint" {
  type                             = string
  description                      = "Matchbox HTTP read-only endpoint (e.g. http://matchbox.example.com:8080)"
  default                          = "http://dns2.adrp.xyz:8080"
}

variable "matchbox_rpc_endpoint" {
  type                             = string
  description                      = "Matchbox gRPC API endpoint, without the protocol (e.g. matchbox.example.com:8081)"
  default                          = "dns2.adrp.xyz:8443"
}

variable "matchbox_rpc_ca" {
  type                             = string
  description                      = "Path to the CA used by the matchbox server."
  default                          = ""
}

variable "matchbox_rpc_client_key" {
  type                             = string
  description                      = "Path to the client key used to authenticate to the matchbox server."
  default                          = ""
}

variable "matchbox_rpc_client_cert" {
  type                             = string
  description                      = "Path to the client cert used to authenticate to the matchbox server."
  default                          = ""
}

variable "ssh_authorized_keys" {
  type                             = list(string)
  description                      = "Path to the client cert used to authenticate to the matchbox server."
  default                          = [
    "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAF/R3bjaZYUB6cJe7jcexHc+n+zk+F+39SH55nHWk1uqX5h+/YSkDlDPl42QfVVcV/kyX21yv3zUO3zl6h+OsDltgH9+VggOJSvrYYWLx5vb9H3gH6y3yfc2V8Eyg6v4svSE2z6SbRmQw/bLmCcCU+C+oC74du/a/VJocT4ib706LMG2A=="
  ]
}

variable "matchbox_profile" {
  type                             = string
  description                      = "Name to add to add profiles and groups that are created here"
  default                          = ""
}

variable "talos_profiles" {
  type                              = map(object({
    kernel                          = string
    initrd                          = list(string)
    args                            = list(string)
  }))
  default                           = { }
}

variable "talos_group" {
  type                              = map(object({
    profile                         = string
    selector                        = map(string)
    metadata                        = optional(map(string), {})
  }))
  default                           = { }
}
