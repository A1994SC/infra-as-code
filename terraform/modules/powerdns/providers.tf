terraform {
  required_providers {
    powerdns = {
      source  = "pan-net/powerdns"
      version = ">=1.5.0"
    }
    sops = {
      source = "carlpett/sops"
      version = ">=1.0.0"
    }
  }
}
