# Infrastructure as code

Collection different usage of `IaC` projects for personal use.

## Terraform

The `terraform/` has the modules to create Powerdns Records and Matchbox PXE boot profiles.

### Inventories

The current inventories I am creating.

* `core`: the core dns records used for intranet.
* `omada`: the omada dns records used for intranet.
* `personal`: the personal dns records used for intranet.

#### Kubernetes clusters

* `titania`
* `oberon`

### Environment VARS

These environment variables must be populated to properly work with the terraform modules

#### PowerDNS

* `PDNS_API_KEY`: The key used to authentication against the PowerDNS API.
* `PDNS_SERVER_URL`: The FQDN or IP, with port, of the PowerDNS API.
* `PDNS_CACERT`: The CA used by the reverse proxy infront of the PowerDNS API.

#### Match box

* `TF_VAR_matchbox_rpc_ca`: That path to the Matchbox CA.
* `TF_VAR_matchbox_rpc_client_key`: That path to the Matchbox client key.
* `TF_VAR_matchbox_rpc_client_cert`: That path to the Matchbox client cert.

## Packer

Coming soon.

## DIRENV

This project makes use of [direnv](https://direnv.net/) to load and unload environment vars per directory. It is not required but a useful program.
