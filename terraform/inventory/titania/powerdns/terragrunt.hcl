include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/powerdns/"
}

dependencies {
  paths = [
    "../../core/powerdns"
  ]
}

inputs = {
  records = {
    "titania-kc" = {
      zone    = "adrp.xyz."
      set_ptr = false
      record = [
        "10.3.20.9"
      ]
    }
  }
}
