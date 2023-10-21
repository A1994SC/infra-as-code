variable "matchbox_http_endpoint" {
  type                             = string
  description                      = "Matchbox HTTP read-only endpoint (e.g. http://matchbox.example.com:8080)"
  default                          = "http://dns2.adrp.xyz:8080"
}

variable "matchbox_rpc_endpoint" {
  type                             = string
  description                      = "Matchbox gRPC API endpoint, without the protocol (e.g. matchbox.example.com:8081)"
  default                          = "10.3.10.6:8443"
}

variable "matchbox_rpc_ca" {
  type                             = string
  description                      = "Path to the CA used by the matchbox server"
  default                          = ""
}

variable "matchbox_rpc_client_key" {
  type                             = string
  description                      = "Path to the client key used to authenticate to the matchbox server"
  default                          = ""
}

variable "matchbox_rpc_client_cert" {
  type                             = string
  description                      = "Path to the client cert used to authenticate to the matchbox server"
  default                          = ""
}

variable "ssh_authorized_keys" {
  type                             = list(string)
  description                      = "Path to the client cert used to authenticate to the matchbox server"
  default                          = [
    "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAF/R3bjaZYUB6cJe7jcexHc+n+zk+F+39SH55nHWk1uqX5h+/YSkDlDPl42QfVVcV/kyX21yv3zUO3zl6h+OsDltgH9+VggOJSvrYYWLx5vb9H3gH6y3yfc2V8Eyg6v4svSE2z6SbRmQw/bLmCcCU+C+oC74du/a/VJocT4ib706LMG2A=="
  ]
}

variable "matchbox_domain" {
  type                             = string
  description                      = "The domain to use for creating the matchbox settings"
  default                          = "adrp.xyz"
}

variable "matchbox_profile_name" {
  type                             = string
  description                      = "Name to add to add profiles and groups that are created here"
  default                          = ""
}

variable "matchbox_talos" {
  type                             = map(object({
    selector                       = map(string)
    records                        = list(string)
    version                        = optional(string, "")
    arch                           = optional(string, "amd64")
    type                           = optional(string, "worker")
    extra_args                     = optional(list(string), [])
    set_ptr                        = optional(bool, true)
    metadata                       = optional(map(string), {})
    install_drive                  = optional(string, "/dev/nvme0n1")
  }))
  description                      = "List of matchbox settings to create; creates both profile(s) and group(s)"
  default                          = { }
}

variable "matchbox_talos_args" {
  type                             = list(string)
  description                      = "List of args to use with the talos profile."
  default                          = [
    "init_on_alloc=1",
    "slab_nomerge",
    "pti=on",
    "console=tty0",
    "console=ttyS0",
    "printk.devkmsg=on",
    "talos.platform=metal"
  ]
}

variable "matchbox_talos_version" {
  type                             = string
  description                      = "Talos vesion"
  default                          = "v1.5.3"
}

variable "matchbox_talos_kubernetes_version" {
  type                             = string
  description                      = "Talos vesion"
  default                          = "v1.28.2"
}

variable "matchbox_talos_config" {
  description                      = ""
  type                             = object({
    machine_token                  = string
    machine_ca_cert                = string
    machine_ca_key                 = string
    cluster_id                     = string
    cluster_secret                 = string
    cluster_token                  = string
    cluster_secretbox              = string
    cluster_ca_cert                = string
    cluster_ca_key                 = string
    cluster_ca_agg_cert            = string
    cluster_ca_agg_key             = string
    cluster_sa_key                 = string
    cluster_etcd_ca_cert           = string
    cluster_etcd_ca_key            = string
  })
  default                          = null
}
