provider "matchbox" {
  endpoint    = var.matchbox_rpc_endpoint
  ca          = file("${var.matchbox_rpc_ca}")
  client_key  = file("${var.matchbox_rpc_client_key}")
  client_cert = file("${var.matchbox_rpc_client_cert}")
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

resource "matchbox_profile" "talos" {
  for_each                         = var.matchbox_talos
  name                             = "${var.matchbox_profile_name}-${each.key}"
  kernel                           = each.value.kernel
  initrd                           = each.value.initrd
  args                             = concat(
    [
      "initrd=initramfs-${each.value.arch}.xz",
      "talos.hostname=${var.matchbox_profile_name}-${each.key}"
    ],
    var.matchbox_talos_args,
    each.value.extra_args
  )
}

resource "matchbox_group" "talos" {
  depends_on                       = [ matchbox_profile.talos ]
  for_each                         = var.matchbox_talos
  name                             = "${var.matchbox_profile_name}-${each.key}"
  profile                          = "${var.matchbox_profile_name}-${each.key}"
  selector                         = each.value.selector
  metadata                         = each.value.metadata
}
