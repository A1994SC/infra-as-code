include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/matchbox/"
}

dependencies {
  paths = [
    "../powerdns"
  ]
}

inputs = {
  matchbox_profile_name = "titania"

  matchbox_talos = {
    "kc1" = {
      records = ["10.3.20.10"]
      type    = "control-plane"
      selector = {
        mac = "94:c6:91:a6:87:66" # 94-c6-91-a6-87-66
      }
    }
    "kc2" = {
      records = ["10.3.20.11"]
      type    = "control-plane"
      selector = {
        mac = "94:c6:91:a2:a0:75" # 94-c6-91-a2-a0-75
      }
    }
    "kc3" = {
      records = ["10.3.20.12"]
      type    = "control-plane"
      selector = {
        mac = "94:c6:91:a2:99:fe" # 94-c6-91-a2-99-fe
      }
    }
    "ki1" = {
      records = ["10.3.20.20"]
      selector = {
        mac = "94:c6:91:a0:84:27" # 94-c6-91-a0-84-27
      }
    }
    "ki2" = {
      records = ["10.3.20.21"]
      selector = {
        mac = "94:c6:91:1d:de:50" # 94-c6-91-1d-de-50
      }
    }
    "ki3" = {
      records = ["10.3.20.22"]
      selector = {
        mac = "94:c6:91:ad:c6:80" # 94-c6-91-ad-c6-80
      }
    }
    "kw1" = {
      records = ["10.3.20.28"]
      selector = {
        mac = "94:c6:91:1d:60:ff" # 94-c6-91-1d-60-ff
      }
      install_drive = "/dev/sda"
    }
    "kw2" = {
      records = ["10.3.20.29"]
      selector = {
        mac = "94:c6:91:1f:1d:15" # 94-c6-91-1f-1d-15
      }
      install_drive = "/dev/sda"
    }
    "kw3" = {
      records = ["10.3.20.30"]
      selector = {
        mac = "1c:69:7a:a5:ca:ca" # 1c-69-7a-a5-ca-ca
      }
      # install_drive = "/dev/sda"
    }
  }
}
