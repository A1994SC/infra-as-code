provider "matchbox" {
  endpoint    = var.matchbox_rpc_endpoint
  ca          = file("${var.matchbox_rpc_ca}")
  client_key  = file("${var.matchbox_rpc_client_key}")
  client_cert = file("${var.matchbox_rpc_client_cert}")
}

resource "matchbox_profile" "list" {
  for_each                         = var.talos_profiles
  name                             = "${var.matchbox_profile}-${each.key}"
  kernel                           = each.value.kernel
  initrd                           = each.value.initrd
  args                             = each.value.args
}

resource "matchbox_group" "list" {
  depends_on                       = [ matchbox_profile.list ]
  for_each                         = var.talos_group
  name                             = "${var.matchbox_profile}-${each.key}"
  profile                          = "${var.matchbox_profile}-${each.value.profile}"
  selector                         = each.value.selector
  metadata                         = each.value.metadata
}
