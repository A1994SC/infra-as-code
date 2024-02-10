variable "zones" {
  type                             = map(object({
    kind                           = optional(string, "Native")
    soa_edit_api                   = optional(string, null)
    nameservers                    = optional(list(string), [ "10.3.10.5.", "10.3.10.6." ])
  }))
  description                      = "List of domain zones to create"
  default                          = { }
}

variable "subzones" {
  type                             = map(object({
    soa_edit_api                   = optional(string, null)
    masters                        = optional(list(string), [ "10.3.10.5", "10.3.10.6" ])
  }))
  description                      = "List of subdomain zones to create"
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
  description                      = "List of records to create"
  default                          = { }
}
