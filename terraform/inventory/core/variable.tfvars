zones                              = {
  "adrp.xyz."                      = { }
  "10.in-addr.arpa."               = { }
}

records                            = {
  "dns1"                           = {
    zone                           = "adrp.xyz."
    record                         = [ "10.3.10.5" ]
  }
  "dns2"                           = {
    zone                           = "adrp.xyz."
    record                         = [ "10.3.10.6" ]
  }
  "matchbox"                       = {
    zone                           = "adrp.xyz."
    record                         = [ "10.3.20.6" ]
  }
  "step"                       = {
    zone                           = "adrp.xyz."
    record                         = [ "10.3.20.5" ]
  }
}
