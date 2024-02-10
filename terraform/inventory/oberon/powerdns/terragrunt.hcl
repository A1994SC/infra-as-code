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
    "oberon-kc1" = {
      zone   = "adrp.xyz."
      record = ["10.3.25.30"]
    }
    "oberon-kc2" = {
      zone   = "adrp.xyz."
      record = ["10.3.25.31"]
    }
    "oberon-kc3" = {
      zone   = "adrp.xyz."
      record = ["10.3.25.32"]
    }
    "oberon-ki1" = {
      zone   = "adrp.xyz."
      record = ["10.3.25.40"]
    }
    "oberon-ki2" = {
      zone   = "adrp.xyz."
      record = ["10.3.25.41"]
    }
    "oberon-ki3" = {
      zone   = "adrp.xyz."
      record = ["10.3.25.42"]
    }
    "oberon-ki4" = {
      zone   = "adrp.xyz."
      record = ["10.3.25.43"]
    }
    "oberon-ki5" = {
      zone   = "adrp.xyz."
      record = ["10.3.25.44"]
    }
    "oberon-kw1" = {
      zone   = "adrp.xyz."
      record = ["10.3.25.50"]
    }
    "oberon-kw2" = {
      zone   = "adrp.xyz."
      record = ["10.3.25.51"]
    }
    "oberon-kw3" = {
      zone   = "adrp.xyz."
      record = ["10.3.25.52"]
    }
    "oberon-kw4" = {
      zone   = "adrp.xyz."
      record = ["10.3.25.53"]
    }
    "oberon-kw5" = {
      zone   = "adrp.xyz."
      record = ["10.3.25.54"]
    }
    "oberon-kc" = {
      zone    = "adrp.xyz."
      set_ptr = false
      record = [
        "10.3.25.30",
        "10.3.25.31",
        "10.3.25.32"
      ]
    }
  }
}
