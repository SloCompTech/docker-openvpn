# Documentation

## Table of content

1. Commands

- [Simple setup guide](SetupGuide.md)  

## Commands

This section explains commands available for use.

### Command List

|**Command**|**Description**|
|:---------:|:-------------:|
|`ovpn_backup`|Backups your configration|
|`ovpn_client`|Manages clients|
|`ovpn_disconf`|Deletes active OpenVPN config|
|`ovpn_enconf`|Enables OpenVPN config from examples|
|`ovpn_init`|Inits PKI|

#### ovpn_backup

This command backups your configration into *.tar.gz* archive and puts it into `/config/backup` directory.

```
Usage: ovpn_backup COMMAND

Commands:
  all     # Backup whole config directory"
  pki     # Backup PKI files"
  hooks   # Backup hooks"
  openvpn # Backup openvpn live config"
```

**Note:** Store your backups in a **SECURE** way, because they are unecrypted.  

#### ovpn_client

This commands manages clients of your OpenVPN server.

```
Usage: ovpn_client COMMAND [ARGS]

Commands:
  add [NAME [nopass]]             # Creates certificates for client
  ovpn NAME                       # Builds .ovpn file
  revoke|ban|delete|remove NAME   # Removes client
```

**Note:** First you need to use `add` to create client certificates, before you can use `ovpn` command.

#### ovpn_disconf

This command deletes your active configuration. **Container restart** is needed for changes to take affect.

```
Usage: ovpn_disconf
```

**NOTE:** This command does not delete PKI.

#### ovpn_enconf

This command enables OpenVPN config based on config example. If config name isn't specified it prints out config list.

```
Usage: ovpn_enconf CONFIG_NAME [wizard args...]

Configs:
    <example config name>
```

**Note:** Please read example documentation to understand how to use it.
**Warning:** Some examples automaticaly add firewall rules, so if you are using host networking make sure to check **iptables** for correct configuration.     
**Tip:** If you modifed config in a way that others might need same configuration, consider making new example.  

#### ovpn_init

This command inits your PKI in `/config/pki` folder. You need to run this command only once.  

```
Usage: ovpn_init [nopass]
```

**Note:** Best practise is to use password for your PKI. Password is only needed for signing new certificates (when adding new clients). If you don't want your PKI certificate protected with password, add `nopass` parameter.  
**Note:** In this process you need to enter PKI password serveral times, because a lot of things are generated.  

