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
    "router.omada" = {
      zone   = "adrp.xyz."
      record = ["10.3.0.1"]
    }
    "wee-fee.omada" = {
      zone   = "adrp.xyz."
      record = ["10.3.0.10"]
    }
    "poe-1.omada" = {
      zone   = "adrp.xyz."
      record = ["10.3.0.3"]
    }
    "back-1.omada" = {
      zone   = "adrp.xyz."
      record = ["10.3.0.5"]
    }
    "controler.omada" = {
      zone   = "adrp.xyz."
      record = ["10.3.0.4"]
    }
  }
}
