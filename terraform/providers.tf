terraform {
  required_providers {
    powerdns = {
      source  = "pan-net/powerdns"
      version = ">=1.5.0"
    }
    ct = {
      source  = "poseidon/ct"
      version = ">=0.11.0"
    }
    matchbox = {
      source  = "poseidon/matchbox"
      version = ">=0.5.2"
    }
  }
}
