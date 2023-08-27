terraform {
  required_providers {
    powerdns = {
      source  = "pan-net/powerdns"
      version = "1.5.0"
    }
  }
}

provider "powerdns" { }

# resource "powerdns_zone" "adrp-xyz" {
#   name        = "adrp.xyz."
#   kind        = "Native"
#   nameservers = ["dns1.adrp.xyz.", "dns2.adrp.xyz."]
# }

# resource "powerdns_zone" "native-arpa" {
#   name        = "10.in-addr.arpa."
#   kind        = "Native"
#   nameservers = ["dns1.adrp.xyz.", "dns2.adrp.xyz."]
# }



locals {
  ptr_record = merge([
    for key, rec in var.records : {
      for index, address in rec.record : "${key}-${index}" => {
        name = "${format("%s.%s.%s.%s.in-addr.arpa.",
          element(split(".", address), 3),
          element(split(".", address), 2),
          element(split(".", address), 1),
          element(split(".", address), 0))
        }"
        record = [ "${key}.${rec.zone}" ]
      }
    }
    if rec.set_ptr
  ]...)
}

resource "powerdns_zone" "zones" {
  for_each                         = var.domains
  name                             = "${each.key}"
  kind                             = each.value.kind
  nameservers                      = each.value.nameservers
}

resource "powerdns_record" "records" {
  depends_on                       = [ powerdns_zone.zones ]
  for_each                         = var.records
  set_ptr                          = false
  ttl                              = each.value.ttl
  name                             = "${each.key}.${each.value.zone}"
  zone                             = each.value.zone
  records                          = each.value.record
  type                             = each.value.type
}

resource "powerdns_record" "records-ptr" {
  depends_on                       = [ powerdns_zone.zones ]
  for_each                         = local.ptr_record
  ttl                              = 300
  set_ptr                          = false
  type                             = "PTR"
  zone                             = "10.in-addr.arpa."
  name                             = "${each.value.name}"
  records                          = each.value.record
}
