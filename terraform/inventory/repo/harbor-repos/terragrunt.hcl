include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/harbor-repos/"
}

inputs = {
  harbor_http_endpoint          = "https://harbor.titania.adrp.xyz"
  harbor_http_endpoint_insecure = true

  harbor_proxy                  = {
    docker-io                   = {
      url                       = "https://hub.docker.com"
      provider                  = "docker-hub"
    }
    step-io                     = {
      url                       = "https://cr.step.sm"
    }
    gcr-io                      = {
      url                       = "https://gcr.io"
    }
    ghcr-io                     = {
      url                       = "https://ghcr.io"
    }
    quay-io                     = {
      url                       = "https://quay.io"
    }
    k8s-io                      = {
      url                       = "https://registry.k8s.io"
    }
    zalan                       = {
      url                       = "https://registry.opensource.zalan.do"
    }
    upbound-io                  = {
      url                       = "https://xpkg.upbound.io"
    }
    factory-talos-dev           = {
      url                       = "https://factory.talos.dev"
    }
  }
}
