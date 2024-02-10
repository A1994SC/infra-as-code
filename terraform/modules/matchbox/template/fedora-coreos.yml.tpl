variant: fcos
version: 1.5.0
ignition:
  security:
    tls:
      certificate_authorities:
      - inline: |
          -----BEGIN CERTIFICATE-----
          MIIBdDCCARqgAwIBAgIRANkYt8S37DW7KItbxVZr9OUwCgYIKoZIzj0EAwIwGDEW
          MBQGA1UEAxMNRGVycHkgUm9vdCBDQTAeFw0yMDEyMzEwMDI1NTNaFw0zMDEyMzEw
          MDI1NTNaMBgxFjAUBgNVBAMTDURlcnB5IFJvb3QgQ0EwWTATBgcqhkjOPQIBBggq
          hkjOPQMBBwNCAATOFoME0It/e323PaeOgrrQZGUGbz3AovjJBBDLAkwld057duoq
          2ppzrcNQYm3/KfFJrGZUbel0PHpIqh4ufFJWo0UwQzAOBgNVHQ8BAf8EBAMCAQYw
          EgYDVR0TAQH/BAgwBgEB/wIBATAdBgNVHQ4EFgQUSCs2bRDtMPz4sfHi3sUfJLw5
          nVgwCgYIKoZIzj0EAwIDSAAwRQIhALmYLFGo9FUAGP6wY8vj1Q5wRXW6n6xV/S6T
          RG/LtMsYAiBwzyJT5Ht+D/KnxHCqhDTxb/kQQL41IyEcswrIdDF4wA==
          -----END CERTIFICATE-----
        verification:
          hash: sha512-194e25f9291a5fb84448c5fcd3f590ca6e1b244e82fa2d4576ed8541df79ce58beee1de0a25fe695eed1a3f1725143a55870fd12325c1da732310acf8936a3e3
passwd:
  users:
    - name: core
      ssh_authorized_keys:
%{ for key in ssh_authorized_keys ~}
        - ${key}
%{ endfor ~}
