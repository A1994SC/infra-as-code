records                 = {
  "titania-kc1"         = {
    zone                = "adrp.xyz."
    record              = [ "10.3.20.10" ]
  }
  # "titania-kc2"         = {
  #   zone                = "adrp.xyz."
  #   record              = [ "10.3.20.11" ]
  # }
  # "titania-kc3"         = {
  #   zone                = "adrp.xyz."
  #   record              = [ "10.3.20.12" ]
  # }
  "titania-kw1"         = {
    zone                = "adrp.xyz."
    record              = [ "10.3.20.20" ]
  }
  "titania-kw2"         = {
    zone                = "adrp.xyz."
    record              = [ "10.3.20.21" ]
  }
  "titania-kw3"         = {
    zone                = "adrp.xyz."
    record              = [ "10.3.20.22" ]
  }
  "titania-kc"          = {
    zone                = "adrp.xyz."
    set_ptr             = false
    record              = [
      "10.3.20.10"
      # "10.3.20.11",
      # "10.3.20.12"
    ]
  }
}

# matchbox_profile                   = "titania"

# talos_profiles                     = {
#   "control-plane"                  = {
#     kernel                         = "/assets/talos/v1.5.1/vmlinuz-amd64"
#     initrd                         = [ "/assets/talos/v1.5.1/initramfs-amd64.xz" ]
#     args                           = [
#       "initrd=initramfs-amd64.xz",
#       "init_on_alloc=1",
#       "slab_nomerge",
#       "pti=on",
#       "console=tty0",
#       "console=ttyS0",
#       "printk.devkmsg=on",
#       "talos.platform=metal",
#       "talos.config=http://dns2.adrp.xyz:8080/assets/talos/cluster/titania/controlplane.yml"
#     ]
#   }
#   "worker"                         = {
#     kernel                         = "/assets/talos/v1.5.1/vmlinuz-amd64"
#     initrd                         = [ "/assets/talos/v1.5.1/initramfs-amd64.xz" ]
#     args                           = [
#       "initrd=initramfs.xz",
#       "init_on_alloc=1",
#       "slab_nomerge",
#       "pti=on",
#       "console=tty0",
#       "console=ttyS0",
#       "printk.devkmsg=on",
#       "talos.platform=metal",
#       "talos.config=http://dns2.adrp.xyz:8080/assets/talos/cluster/titania/worker.yaml"
#     ]
#   }
# }

# talos_group                        = {
#   "kc1"                            = {
#     profile                        = "control-plane"
#     selector                       = {
#       mac                          = "94:c6:91:a2:a0:75"
#     }
#   }
#   "kc2"                            = {
#     profile                        = "control-plane"
#     selector                       = {
#       mac                          = "94:c6:91:a6:87:66"
#     }
#   }
# }
