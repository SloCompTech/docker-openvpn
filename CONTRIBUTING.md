# Contribute guide

Feel free to contribute to this project.  

## Table of contents

Sections:

- [Example configs & hooks](root/defaults/example/README.md)
- [Guides](docs/README.md)
- [Helper Scripts](root/app/README.md)  
- [Modules](root/defaults/module/README.md)

## Syntax

- Identation: space (2 spaces width)
- Javadoc style documentation

## Directory structure of project

```
/config # Configuration dir (all config is here, generated on container start)
  backup # Folder where backups are generated
  example # Example configs (see root/defaults/example/README.md)
  module # Modules for openvpn
  openvpn # Openvpn configuration
    ccd # OpenVPN client-specific configuration directory (applied when client connects)
    client # Client configuration directory (for generation of .ovpn files)
      <clientconffile>.conf # Base for building client config (all files merged)
    config # Running config (server/client)
      <name>.conf # Config files (all files merged)
    hooks # Put your custom scripts in one of subfolders
      auth # On authentication (needs to be enabled in config)
      client-connect # Client connected
      client-disconnect # Client disconnected
      down # After interface is down
      finish # Deinit container
      init # Init container
      learn-address
      route-up # After routes are added
      route-pre-down # Before routes are removed
      up # After interface is up  
      tls-verify # Check certificate
    system.conf # System OpenVPN config file (do not edit, unless instructed)
    system-server.conf # System OpenCPN server specific file (do not edit, unless instructed)
    system-client.conf # System OpenCPN client specific file (do not edit, unless instructed)
    dynamic.conf # File that links all config files together (automatically generated)
  pki
    ca.crt # CA certificate
    certs by serial # Certs by Serial ID
      <serial-id-cert>.pem
    crl.pem # CRL
    dh.pem
    index.txt # Database index file
    issued
      <name>.crt # Certificates
    private # Directory with private keys
      ca.key # CA secret
      <name>.key # Certificate secrets
    reqs # Directroy with signing requests
    secret.key # Static key (if not using real PKI)
    serial # The current serial number
    ta.key # Secret for tls-auth, tls-crypt
  ssl
    safessl-easyrsa.cnf
    vars
  tmp # Temporary folder
/defaults # Default configuration, which is copied into config on full setup
  ...
/etc # System config
  cont-init.d # Scripts run before services are started
  cont-finish.d # Scripts run after services are finished
  fix-attrs.d # Fix file permissions
  services.d  # Scripts that start services
```

## Useful links

**Project:**  

- [Versioning](https://semver.org/)  
- [Container labels](https://github.com/opencontainers/image-spec/blob/master/annotations.md)  
- [Container badges](https://microbadger.com/about)  
- [s6 overlay](https://github.com/just-containers/s6-overlay)  

**OpenVPN:**  

- [OpenVPN docs](https://community.openvpn.net/openvpn/wiki/GettingStartedwithOVPN)  
- [Setup OpenVPN on alpine linux](https://wiki.alpinelinux.org/wiki/Setting_up_a_OpenVPN_server#Alternative_Certificate_Method)  
- [EasyRSA](https://community.openvpn.net/openvpn/wiki/GettingStartedwithOVPN)
- [EasyRSA doc](https://github.com/OpenVPN/easy-rsa/tree/master/doc)
