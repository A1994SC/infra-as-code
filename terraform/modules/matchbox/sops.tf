provider "sops" {}

data "sops_file" "matchbox" {
  source_file = "sops.enc.yml"
}
