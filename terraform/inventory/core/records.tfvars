domains                            = {
  "adrp.xyz."                      = {
    nameservers                    = [
      "dns1.adrp.xyz.",
      "dns2.adrp.xyz."
    ]
  }
  "10.in-addr.arpa."               = {
    nameservers                    = [
      "10.3.10.5.",
      "10.3.10.6."
    ]
  }
}

records                            = {
  "router.omada"                   = {
    zone                           = "adrp.xyz."
    record                         = [ "10.3.0.1" ]
  }
  "wee-fee.omada"                  = {
    zone                           = "adrp.xyz."
    record                         = [ "10.3.0.2" ]
  }
  "poe-1.omada"                    = {
    zone                           = "adrp.xyz."
    record                         = [ "10.3.0.3" ]
  }
  "controler.omada"                = {
    zone                           = "adrp.xyz."
    record                         = [ "10.3.0.4" ]
  }
  "dns1"                           = {
    zone                           = "adrp.xyz."
    record                         = [ "10.3.10.5" ]
  }
  "dns2"                           = {
    zone                           = "adrp.xyz."
    record                         = [ "10.3.10.6" ]
  }
}
