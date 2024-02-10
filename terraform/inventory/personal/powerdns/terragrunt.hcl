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
    "sentry.personal" = {
      zone   = "adrp.xyz."
      record = ["10.3.30.5"]
    }
    "laptop.personal" = {
      zone   = "adrp.xyz."
      record = ["10.3.30.10"]
    }
    "puck" = {
      zone   = "adrp.xyz."
      record = ["10.3.30.11"]
    }
  }
}
