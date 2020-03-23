# Changelog

### 3.0.0 - New major release

- Changed fs structure
- Rewritten helper scripts
- Reorganized examples
- Added Site-to-site example
- Removed `compression` from examples
- Switched to bash wizards
- Added auth-pass-verify example script

### 2.0.6 - Fixed bugs, added additonal parameters

- Fixed bug in `ovpn` util.
- Moved `tmp-dir` to server related config.
- Fixed bug in dockumentation (GUID -> PGID).
- Added `SKIP_APP` parameter (to skip app startup).
- Added `NO_CHOWN` parameter (don't fix config files permissions).

### 2.0.3 - Improved IPv6 support & finalized client mode support

- Added some IPv6 settings to examples
- Sleep interval on crash
- Outsourced server specific config to `system-server.conf`
- Added parameter `MODE` so you can choose **client** mode instead of server (to not include server specific options)

### 2.0.2 - Added multi-instance support

- Added `TUNNEL_INTERFACE` to set interface name (in case of multiple containers)
- Some fixes for general user
- Changed generation of `include-conf.conf` to `dynamic.conf`

### 2.0.1 - Fix service start

- Fixed command for starting service

### 2.0.0 - Partial rewrite

- Moved `/config/hooks` to `/config/openvpn/hooks`
- Renamed `/config/openvpn/server` to `config`
- Changed base image to [slocomptech/baseimage-alpine](https://github.com/SloCompTech/docker-baseimage-alpine)
- Moved all helper scripts to `/root/usr/local/bin`
- Got rid of bash lib files
- Hiearhicaly moved all commands under the hood of `ovpn` command
- Improved backup command
- Added restore command
- Changed base image
- Added **armhf** build

### 1.0.6 - Bugfix

- Added missing `DNS` keyword to **dhcp-option** in example configs
- Removed `ping` from client config in examples, because `keepalive` is set on a server

### 1.0.5 - Bugfix, finish hook, persistent interface, no firewall ...

- Fixed bug when running hooks (#3)
- Added **finish** hook (which runs just before container exit)
- Added **persistent interface** option, so interface is persistently present on device (if using host networking mode) and firewall setup rules are executed **only once** (no ip tables mess) (#1)
- Logging chaned to stdout, no more log file by default
- Added **firewall disable** feature to disable all firewall related modifications
- Added `ìp6tables` & more permissions to *ip utils*
- Run OpenVPN only if config is present in `/config/openvpn/server` else **sleep forever** until config was setup & **CONTAINER RESTART**

### 1.0.4 - IPv6 docs, improved wizards

- Added instructions for IPv6 configuration
- Added outside interface option to setup wizards
- Added some links to documentation

### 1.0.3 - New examples, fixes, more docs

- Updated instructions
- Improved `Makefile`
- Allowed **ping** to the container
- Added new examples **basic_nat_wlp** and **basic_routed**
- Added **LAN protection** to original example
- Added **docker-compose** for sample

### 1.0.2 - Official release

- Fixed typo in `basic_nat` example config wizard  
- Consistency fix in `Makefile`  
- Added docs for *basic_nat* example  
- Added docs for commands, simple setup guide  
- Added badges to `README.md`  

### 1.0.1 -  First version of OpenVPN container

Implemented:

- PKI handling with scripts
- Hooks scripts (in separate directories)
- Example config with wizard
- Docker Hub hook

Still missing:

- Documentation
- Dicrobadger badges
