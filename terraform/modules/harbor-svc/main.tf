provider "harbor" {
  url         = var.harbor_http_endpoint
  username    = var.harbor_admin_username
  password    = var.harbor_admin_password
  insecure    = true
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
