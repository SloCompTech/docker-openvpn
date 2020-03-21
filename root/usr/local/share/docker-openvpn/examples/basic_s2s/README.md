# basic_s2s

Features:  

- Site-to-site VPN

## Configuration

``` bash
# PKI init
ovpn pki init [nopass]

# Load example
ovpn example basic_s2s

# Certifcates
# NOTE: To also use server certificates for p2p connection between servers
#       add clientAuth to extendedKeyUsage before generating certificate
ovpn subject add first server [nopass]
# Change filenames in config file

ovpn subject add second server [nopass]
ovpn subject gen-pkg second # creates .tar.gz in client-confs
# Copy .tar.gz to second machine
ovpn load NAME.pkg.tar.gz # Second machine
```

## External docs

- [Tutorial 1](https://zeldor.biz/2010/12/openvpn-site-to-site-setup/)
