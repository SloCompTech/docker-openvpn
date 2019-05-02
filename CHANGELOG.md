# Changelog

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
