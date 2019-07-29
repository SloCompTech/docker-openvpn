# Commands

This chapter shows available commands.

``` bash
$ ovpn help
Usage: ovpn COMMAND [ARGS..]

Commands:
  backup                                            # Creates backup of configuration files
  client [add|ovpn|ban|revoke|remove|delete|help] [NAME] [nopass] # Client manipulation
  disconf                                           # Deletes active config
  enconf  EXAMPLE_CONFIG_NAME [wizard args]         # Enable example config
  pki [init|remove|delete]                          # Public Key Intrastructure
  restore ARCHIVE_FILE                              # Restores backup
```

## ovpn backup

This command backups your configration into **.tar.gz** archive and puts it into `/config/backup` directory.

### Usage

``` bash
$ ovpn backup
```

**Note:** Store your backups in a **SECURE** way, because they are **unencrypted**.  

## ovpn client

This commands manages clients of your OpenVPN server.

``` bash
$ ovpn client help
Usage: ovpn_client COMMAND [ARGS]

Commands:
  add [NAME [nopass]]             # Creates certificates for client
  ovpn NAME                       # Generates .ovpn file (saves to tmp)
  revoke|ban NAME                 # Adds client to CRL
  remove|delete NAME              # Removes client config
```

**Note:** First you need to use `add` to create client certificates, before you can use `ovpn` command.

### Create .ovpn file for client

``` bash
$ ovpn client add CLIENTNAME [nopass]
$ ovpn client ovpn CLIENTNAME 
# .ovpn file is saved to /config/tmp
```

## ovpn disconf

This command deletes your active configuration. **Container restart** is needed for changes to take affect.

```
$ ovpn disconf
```

**NOTE:** This command does not delete PKI.

## ovpn enconf

This command enables OpenVPN config based on config example. If config name isn't specified it prints out config list.

```
$ ovpn enconf help
Usage: ovpn_enconf CONFIG_NAME [wizard args...]

Configs:
  <example config name>
```

**Note:** Please read example documentation to understand how to use it.
**Warning:** Some examples automaticaly add firewall rules, so if you are using host networking make sure to check **iptables** for correct configuration.
**Tip:** If you modifed config in a way that others might need same configuration, consider making new example.  

### Enable basic config

``` bash
$ ovpn enconf basic_nat
```

## ovpn pki

This command handles PKI, which is needed for using TLS on server.

``` bash
$ ovpn pki help
Usage: ovpn_pki COMMAND

Commands:
  delete|remove      # Removes PKI
  init [nopass]      # Init PKI (in /config/pki)
```

**Note:** Best practise is to use password for your PKI. Password is only needed for signing new certificates (when adding new clients). If you don't want your PKI certificate protected with password, add `nopass` parameter.  
**Note:** In this process you need to enter PKI password serveral times, because a lot of things are generated.
