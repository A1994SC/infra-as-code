provider "harbor" {
  url         = var.harbor_http_endpoint
  username    = data.sops_file.harbor.data["harbor.user"]
  password    = data.sops_file.harbor.data["harbor.pass"]
  insecure    = true
}

resource "harbor_registry" "proxy_repos" {
  for_each                         = var.harbor_proxy

  name                             = "${each.key}"
  endpoint_url                     = each.value.url
  provider_name                    = each.value.provider
}

resource "harbor_project" "proxy_projects" {
  for_each                         = harbor_registry.proxy_repos

  name                             = "remote-${each.key}"
  registry_id                      = each.value.registry_id
  public                           = var.harbor_proxy_view
  force_destroy                    = var.harbor_proxy_delete
}
