provider "powerdns" {
  api_key        = data.sops_file.matchbox.data["power.api"]
  ca_certificate = data.sops_file.matchbox.data["power.ca"]
  server_url     = data.sops_file.matchbox.data["power.url"]
  insecure_https = false
}

locals {
  match_ptr_record = merge([
    for key, rec in var.matchbox_talos : {
      for index, address in rec.records : "${key}-${index}" => {
        name = "${format("%s.%s.%s.%s.in-addr.arpa.",
          element(split(".", address), 3),
          element(split(".", address), 2),
          element(split(".", address), 1),
          element(split(".", address), 0))
        }"
        records = [ "${var.matchbox_profile_name}-${key}.${var.matchbox_domain}." ]
      }
    }
    if rec.set_ptr
  ]...)
}

resource "powerdns_record" "match-records" {
  for_each                         = var.matchbox_talos
  ttl                              = 300
  set_ptr                          = false
  type                             = "A"
  zone                             = "${var.matchbox_domain}."
  name                             = "${var.matchbox_profile_name}-${each.key}.${var.matchbox_domain}."
  records                          = each.value.records
}

resource "powerdns_record" "match-records-ptr" {
  for_each                         = local.match_ptr_record
  ttl                              = 300
  set_ptr                          = false
  type                             = "PTR"
  zone                             = "10.in-addr.arpa."
  name                             = "${each.value.name}"
  records                          = each.value.records
}
