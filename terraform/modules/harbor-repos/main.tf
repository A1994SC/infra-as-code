provider "harbor" {
  url         = var.harbor_http_endpoint
  username    = var.harbor_admin_username
  password    = var.harbor_admin_password
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

resource "random_password" "password" {
  length  = 32
  special = false
}

resource "harbor_robot_account" "system" {
  name        = "tf-pull-account"
  description = "system pull robot account"
  level       = "system"
  secret      = resource.random_password.password.result

  permissions {
    access {
      action   = "pull"
      resource = "repository"
    }
    kind      = "project"
    namespace = "*"
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "admin@titania"
}

resource "kubernetes_secret" "example" {
  metadata {
    name = "harbor-robot-token"
    namespace = "secret-store"
  }

  data = {
    username = harbor_robot_account.system.full_name
    password = "${random_password.password.result}"
  }
}
