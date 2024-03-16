provider "sops" {}

data "sops_file" "harbor" {
  source_file = "sops.enc.yml"
}
