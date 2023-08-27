variable "domains" {
  type                             = map(object({
    kind                           = optional(string, "Native")
    nameservers                    = list(string)
  }))
  description                      = "List of domain zones to create."
  default                          = { }
}

variable "records" {
  type                             = map(object({
    zone                           = string
    type                           = optional(string, "A")
    record                         = list(string)
    ttl                            = optional(number, 300)
    set_ptr                        = optional(bool, false)
  }))
  description                      = "List of records to create."
}
