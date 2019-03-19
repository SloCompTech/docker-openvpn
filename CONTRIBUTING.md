# Contribute guide

Feel free to contribute to this project.  

## Table of contents

Sections:

- [Example configs & hooks](root/defaults/example/README.md) 
- [Guides](docs/README.md)
- [Helper Scripts](root/app/README.md)  
- [Modules](root/defaults/module/README.md)

## Syntax

- Identation: tab (4 spaces width)
- Javadoc style documentation

## Directory structure of project

```
/app # Utils (part of image)
    bin # Scripts for using this image
/config # Configuration dir (all config is here, generated on container start)
    openvpn # Openvpn configuration
        ccd # Client config directory
        client # Client configuration directory
            <clientconffile>.conf # Base for building client config (all files merged)
        server # Server configuration directory
            <name>.conf # Server config files (all files merged)
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
        serial # The current serial number
        ta.key # Secret for tls-auth, tls-crypt
    ssl
        safessl-easyrsa.cnf
        vars
    example # Example configs
        config # Example client & server configs (see root/defaults/example/README.md)
        hook # Example hook configs
    module # Modules for openvpn
    hooks # Put your custom scripts in one of subfolders
        init # Init container
        route-up # After routes are added
        route-pre-down # Before routes are removed
        up # After interface is up  
        down # After interface is down
        client-connect # Client connected
        client-disconnect # Client disconnected
        learn-address
        tls-verify # Check certificate
        auth # On authentication (needs to be enabled in config)
    system.conf # System OpenVPN config file (do not edit, unless instructed)
    include-server.conf # File that includes all server configuration files (automatically generated)
    donotdelete # Leave this file alone, if deleted it triggers full setup
/defaults # Default configuration, which is copied into config on full setup
    example # Examples
        config # Example configs
        hook # Example hooks
    module # Modules (for example password authentication ...)
    system.conf # Original server config
/etc # System config
    cont-init.d # Scripts run before services are started
    fix-attrs.d # Fix file permissions
    logrotate.d # Log settings
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