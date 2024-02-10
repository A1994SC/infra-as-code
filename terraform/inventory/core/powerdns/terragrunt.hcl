include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/powerdns/"
}

inputs = {
  zones = {
    "adrp.xyz."        = {}
    "10.in-addr.arpa." = {}
  }

  records = {
    "dns1" = {
      zone   = "adrp.xyz."
      record = ["10.3.10.5"]
    }
    "dns2" = {
      zone   = "adrp.xyz."
      record = ["10.3.10.6"]
    }
    "box" = {
      zone   = "adrp.xyz."
      record = ["10.3.10.8"]
    }
    "matchbox" = {
      zone   = "adrp.xyz."
      record = ["10.3.20.6"]
    }
    "step" = {
      zone   = "adrp.xyz."
      record = ["10.3.20.5"]
    }
  }
}
