terraform {
  required_providers {
    harbor = {
      source = "goharbor/harbor"
      version = ">=3.10.6"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">=2.25.2"
    }
  }
}
