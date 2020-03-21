# Contribute guide

Feel free to contribute to this project.  

## Table of contents

Sections:

- [Example configs & hooks](root/usr/local/share/docker-openvpn/README.md)
- [Guides](docs/README.md)
- [Helper Scripts](root/app/README.md)  

## Syntax

- Identation: space (2 spaces width)
- Javadoc style documentation

## Directory structure of project

``` text
/config # Configuration dir (all config is here, generated on container start)
  backup # Generated backups
  client-configs # Generated client configs
  hooks
    finish # Deinit container
    init # Init container
  openvpn # OpenVPN directory
    ca.crt (*) # CA public key (when pki is setup)
    ccd # client-specific configuration directory (applied when client connects)
    crl.pem (**) # Certificate revocation list
    dh.pem (*) # Server crypto
    hook.sh # Hook script runner
    hooks # Put your custom scripts in one of subfolders
      auth # Server: On authentication (needs to be enabled in config)
      client-connect # Server: Client connected
      client-disconnect # Server: Client disconnected
      down # After interface is down
      ipchange # Client: our remote IP initially authenticated or changes
      learn-address # Server: when IP, route, MAC added to OpenVPN internal routing table
      route-up # After routes are added
      route-pre-down # Before routes are removed
      start # Before service start
      stop # After service stop
      up # After interface is up  
      tls-verify # Check certificate
    include.conf # Container specific settings (must be included)
    openvpn.conf or *.ovpn file # Main configuration file
    openvpn-template.conf # Template configuration for creating .ovpn and .pkg
    pid # OpenVPN PID (automatically written)
    server.crt (*) # Server public key
    server.key (*) # Server private key
    tmp # Temporary directory
  persistent-interface # Make used interface persistent
  pki (**) # Public key infrastructure directory (KEEP IT SAFE, specialy ca.key)
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
  tmp # Temporary directory
  openssl-easyrsa.conf
  safessl-easyrsa.conf
  vars
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
