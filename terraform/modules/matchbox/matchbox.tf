provider "matchbox" {
  endpoint    = var.matchbox_rpc_endpoint
  ca          = data.sops_file.matchbox.data["matchbox.ca"]
  client_key  = data.sops_file.matchbox.data["matchbox.key"]
  client_cert = data.sops_file.matchbox.data["matchbox.crt"]
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
    machine_token                  = data.sops_file.matchbox.data["talos.machine.token"]
    machine_ca_cert                = data.sops_file.matchbox.data["talos.machine.ca.crt"]
    machine_ca_key                 = each.value.type != "worker" ? data.sops_file.matchbox.data["talos.machine.ca.key"]    : ""
    cluster_id                     = data.sops_file.matchbox.data["talos.cluster.id"]
    cluster_secret                 = data.sops_file.matchbox.data["talos.cluster.secret"]
    cluster_token                  = data.sops_file.matchbox.data["talos.cluster.token"]
    cluster_secretbox              = each.value.type != "worker" ? data.sops_file.matchbox.data["talos.cluster.secretBox"] : ""
    cluster_ca_cert                = data.sops_file.matchbox.data["talos.cluster.ca.crt"]
    cluster_ca_key                 = each.value.type != "worker" ? data.sops_file.matchbox.data["talos.cluster.ca.key"]    : ""
    cluster_ca_agg_cert            = each.value.type != "worker" ? data.sops_file.matchbox.data["talos.cluster.agg.crt"]   : ""
    cluster_ca_agg_key             = each.value.type != "worker" ? data.sops_file.matchbox.data["talos.cluster.agg.key"]   : ""
    cluster_sa_key                 = each.value.type != "worker" ? data.sops_file.matchbox.data["talos.cluster.sa"]        : ""
    cluster_etcd_ca_cert           = each.value.type != "worker" ? data.sops_file.matchbox.data["talos.cluster.etcd.crt"]  : ""
    cluster_etcd_ca_key            = each.value.type != "worker" ? data.sops_file.matchbox.data["talos.cluster.etcd.key"]  : ""
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
