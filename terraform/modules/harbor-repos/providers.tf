terraform {
  required_providers {
    harbor = {
      source = "goharbor/harbor"
      version = ">=3.10.6"
    }
    sops = {
      source = "carlpett/sops"
      version = ">=1.0.0"
    }
  }
}
