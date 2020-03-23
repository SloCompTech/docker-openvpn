# Commands

This chapter shows available commands.

``` text
Usage: ovpn COMMAND [ARGS..]
  Commands:
    backup [file] # Backup config (Default location: /config/backup)
    example [EXAMLE] # List examples or load example if name specified
    load FILE # Load configuration (.conf, .ovpn, .pkg.tar.gz)
    pki crl # Updates CRL'
        init [nopass] # Inits PKI with CA (env MODULUS=... for dh.pem modulus)
        reflect # Sync OpenVPN with PKI
        rm|del  # Remove PKI
    restore [file] # Restore config
    subject add NAME {client|server} [nopass] [easy-rsa args]
            gen-ovpn SUBNAME [file] # Generate .ovpn file
            gen-pkg SUBNAME [file] # Generate config package
            import-req FILE # Import signing request
            renew SUBNAME {client|server} [easy-rsa args]
            revoke SUBNAME
            set SUBNAME OPTION [ARGS]
                        ip IP # Only works on server with configured server options
```

## ovpn backup

This command backups your configration into **.tar.gz** archive and puts it into `/config/backup` directory.

``` bash
ovpn backup # Creates *.bck.tar.gz file
ovpn backup FILE # Creates backup
```

**Note:** Store your backups in a **SECURE** way, because they are **unencrypted**.  

## ovpn example

This commands list examples or load one.

``` bash
ovpn example # List examples
ovpn example EXAMPLENAME # Load example (NOTE: This overwrites existing config)
```

**Note:** Please read example documentation to understand how to use it.
**Warning:** Some examples automaticaly add firewall rules, so if you are using host networking make sure to check **iptables** for correct configuration.
**Tip:** If you modifed config in a way that others might need same configuration, consider making new example.  

## openvpn load

This command loads configuration.

``` bash
ovpn load FILE.ovpn # Load .ovpn file
ovpn load FILE.conf # Load .conf file
ovpn load FILE.pkg.tar.gz # Load .pkg.tar.gz
```

## ovpn pki

This command handles PKI, which is needed for using TLS on server.

``` bash
ovpn pki init [nopass] # Init PKI
ovpn pki crl # Regenerates CRL
ovpn pki rm # Delete PKI
```

**Note:** Best practise is to use password for your PKI. Password is only needed for signing new certificates (when adding new clients). If you don't want your PKI certificate protected with password, add `nopass` parameter.  
**Note:** In this process you need to enter PKI password serveral times, because a lot of things are generated.

## ovpn restore

This command restores backup configuration

``` bash
ovpn restore # Restores latest backup from backup directory
ovpn restore FILE
```

## ovpn subject

This commands manages certificates of your OpenVPN server.

``` bash
ovpn subject add NAME client [nopass] # Create client certificate
ovpn subject add NAME server [nopass] # Create server certificate
ovpn subject gen-ovpn NAME # Generate .ovpn from existing cert
ovpn subject gen-pkg NAME # Generate .pkg.tar.gz from existing cert
ovpn subject revoke NAME # Revoke certificate
```

**Note:** First you need to use `add` to create client certificates, before you can use `ovpn` command.
