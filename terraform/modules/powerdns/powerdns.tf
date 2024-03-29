provider "powerdns" {
  api_key        = data.sops_file.powerdns.data["power.api"]
  ca_certificate = data.sops_file.powerdns.data["power.ca"]
  server_url     = data.sops_file.powerdns.data["power.url"]
  insecure_https = false
}

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
  for_each                         = var.zones
  name                             = "${each.key}"
  kind                             = each.value.kind
  soa_edit_api                     = each.value.soa_edit_api
  nameservers                      = each.value.nameservers
}

resource "powerdns_zone" "sub-zones" {
  depends_on                       = [ powerdns_zone.zones ]
  for_each                         = var.subzones
  name                             = "${each.key}"
  kind                             = "Slave"
  soa_edit_api                     = each.value.soa_edit_api
  masters                          = each.value.masters
}

resource "powerdns_record" "records" {
  depends_on                       = [ powerdns_zone.zones, powerdns_zone.sub-zones ]
  for_each                         = var.records
  set_ptr                          = false
  ttl                              = each.value.ttl
  name                             = "${each.key}.${each.value.zone}"
  zone                             = each.value.zone
  records                          = each.value.record
  type                             = each.value.type
}

resource "powerdns_record" "records-ptr" {
  depends_on                       = [ powerdns_zone.zones, powerdns_zone.sub-zones ]
  for_each                         = local.ptr_record
  ttl                              = 300
  set_ptr                          = false
  type                             = "PTR"
  zone                             = "10.in-addr.arpa."
  name                             = "${each.value.name}"
  records                          = each.value.record
}
