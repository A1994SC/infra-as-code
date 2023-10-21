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
  kernel                           = "/assets/talos/${var.matchbox_talos_version}/vmlinuz-${each.value.arch}"
  initrd                           = [ "/assets/talos/${var.matchbox_talos_version}/initramfs-${each.value.arch}.xz" ]
  args                             = concat(
    [
      "initrd=initramfs-${each.value.arch}.xz",
      "talos.hostname=${var.matchbox_profile_name}-${each.key}",
      "talos.config=http://10.3.20.6:8080/assets/talos/ignition/${var.matchbox_profile_name}-${each.key}.ign"
    ],
    var.matchbox_talos_args,
    each.value.extra_args
  )
  raw_ignition = templatefile("${path.root}/template/talos-${each.value.type}.yml", {
    install_drive                  = each.value.install_drive
    talos_version                  = var.matchbox_talos_version
    kubernetes_version             = var.matchbox_talos_kubernetes_version
    hostname                       = "${var.matchbox_profile_name}-${each.key}"
    profile_name                   = var.matchbox_profile_name
    machine_token                  = var.matchbox_talos_config.machine_token
    machine_ca_cert                = var.matchbox_talos_config.machine_ca_cert
    machine_ca_key                 = each.value.type != "worker" ? var.matchbox_talos_config.machine_ca_key     : ""
    cluster_id                     = var.matchbox_talos_config.cluster_id
    cluster_secret                 = var.matchbox_talos_config.cluster_secret
    cluster_token                  = var.matchbox_talos_config.cluster_token
    cluster_secretbox              = each.value.type != "worker" ? var.matchbox_talos_config.cluster_secretbox  : ""
    cluster_ca_cert                = var.matchbox_talos_config.cluster_ca_cert
    cluster_ca_key                 = each.value.type != "worker" ? var.matchbox_talos_config.cluster_ca_key     : ""
    cluster_ca_agg_cert            = each.value.type != "worker" ? var.matchbox_talos_config.cluster_ca_agg_cert: ""
    cluster_ca_agg_key             = each.value.type != "worker" ? var.matchbox_talos_config.cluster_ca_agg_key : ""
    cluster_sa_key                 = each.value.type != "worker" ? var.matchbox_talos_config.cluster_sa_key     : ""
    cluster_etcd_ca_cert           = each.value.type != "worker" ? var.matchbox_talos_config.cluster_etcd_ca_cert: ""
    cluster_etcd_ca_key            = each.value.type != "worker" ? var.matchbox_talos_config.cluster_etcd_ca_key: ""
  })
}

resource "matchbox_group" "talos" {
  depends_on                       = [ matchbox_profile.talos ]
  for_each                         = var.matchbox_talos
  name                             = "${var.matchbox_profile_name}-${each.key}"
  profile                          = "${var.matchbox_profile_name}-${each.key}"
  selector                         = each.value.selector
  metadata                         = each.value.metadata
}
