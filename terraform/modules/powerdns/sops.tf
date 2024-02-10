provider "sops" {}

data "sops_file" "powerdns" {
  source_file = "sops.enc.yml"
}
