records                 = {
  "titania-kc"          = {
    zone                = "adrp.xyz."
    set_ptr             = false
    record              = [
      "10.3.20.12",
      "10.3.20.11",
      "10.3.20.10"
    ]
  }
}

matchbox_profile_name              = "titania"

matchbox_talos                     = {
  "kc1"                            = {
    kernel                         = "/assets/talos/v1.5.2/vmlinuz-amd64"
    initrd                         = [ "/assets/talos/v1.5.2/initramfs-amd64.xz" ]
    records                        = [ "10.3.20.10" ]
    selector                       = {
      mac                          = "94:c6:91:a6:87:66" # 94-c6-91-a6-87-66
    }
    extra_args                     = [
      "talos.config=http://10.3.20.6:8080/assets/talos/cluster/titania/controlplane.yml"
    ]
  }
  "kc2"                            = {
    kernel                         = "/assets/talos/v1.5.2/vmlinuz-amd64"
    initrd                         = [ "/assets/talos/v1.5.2/initramfs-amd64.xz" ]
    records                        = [ "10.3.20.11" ]
    selector                       = {
      mac                          = "94:c6:91:a2:a0:75" # 94-c6-91-a2-a0-75
    }
    extra_args                     = [
      "talos.config=http://10.3.20.6:8080/assets/talos/cluster/titania/controlplane.yml"
    ]
  }
  "kc3"                            = {
    kernel                         = "/assets/talos/v1.5.2/vmlinuz-amd64"
    initrd                         = [ "/assets/talos/v1.5.2/initramfs-amd64.xz" ]
    records                        = [ "10.3.20.12" ]
    selector                       = {
      mac                          = "94:c6:91:a2:99:fe" # 94-c6-91-a2-99-fe
    }
    extra_args                     = [
      "talos.config=http://10.3.20.6:8080/assets/talos/cluster/titania/controlplane.yml"
    ]
  }
  "kw1"                            = {
    kernel                         = "/assets/talos/v1.5.2/vmlinuz-amd64"
    initrd                         = [ "/assets/talos/v1.5.2/initramfs-amd64.xz" ]
    records                        = [ "10.3.20.20" ]
    selector                       = {
      mac                          = "94:c6:91:a0:84:27" # 94-c6-91-a0-84-27
    }
    extra_args                     = [
      "talos.config=http://10.3.20.6:8080/assets/talos/cluster/titania/worker.yml"
    ]
  }
  "kw2"                            = {
    kernel                         = "/assets/talos/v1.5.2/vmlinuz-amd64"
    initrd                         = [ "/assets/talos/v1.5.2/initramfs-amd64.xz" ]
    records                        = [ "10.3.20.21" ]
    selector                       = {
      mac                          = "c4:65:16:1f:d1:65" # c4-65-16-1f-d1-65
    }
    extra_args                     = [
      "talos.config=http://10.3.20.6:8080/assets/talos/cluster/titania/worker.yml"
    ]
  }
  "kw3"                            = {
    kernel                         = "/assets/talos/v1.5.2/vmlinuz-amd64"
    initrd                         = [ "/assets/talos/v1.5.2/initramfs-amd64.xz" ]
    records                        = [ "10.3.20.22" ]
    selector                       = {
      mac                          = "18:c0:4d:83:8d:8a" # 18-c0-4d-83-8d-8a
    }
    extra_args                     = [
      "talos.config=http://10.3.20.6:8080/assets/talos/cluster/titania/worker.yml"
    ]
  }
}
