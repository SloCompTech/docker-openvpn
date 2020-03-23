# Examples

Here are located examples how to configure your OpenVPN server and hooks.

## Copyright & author notice on example

If you care copyright of your contributed material, put JavaDoc style notice in the begining of the file.

``` bash
#
#   Script that ... SHORT DESCRIPTIO
#   @author <name>
#   @version <version>
#   @since <date in DD/MM/YYYY format>
#
```

## Example directory structure
 
Config directory has following structure:  

```
examples
  <example name> # Directory with your examples
    config # Configuration files (will be copied to /config) (See CONTRIBUTING.md for structure)
    wizard # Setup wizard if available
    Readme.md # Info about example, what to configure
```

### Notes

- **MUST** use `dev` attribute in main config file `openvpn.conf` or `*.ovpn`.
- **DO NOT** use any script running directives, because they are probably already set in `include.conf` or `include-server.conf`.
- **DO NOT** use log directives, because they are already set for `log` directory.
- Please name your hooks as `<number>-<name>` to ensure order of execution (make sure that they are executable).
- If your hooks need access to container environment variables add `#!/usr/bin/with-contenv bash` at the top of the file (only hooks outside *openvpn*).

### Wizard

Wizard is script that helps user to simply configure your example to his needs.
User will call `ovpn example EXAMPLENAME [wizard args]` to load your example.  

Then there are two options:

1. User manualy configure settings in `/config/openvpn` folder
2. Your **wizard** script, configures files which will be copied to `/config/openvpn`
    - Configuration files are copied to temporary location (so they can be modified)
    - `wizard` script will be called with temporary location as first argument `$1` (folder has same structure as in examples)
    - Your `wizard` script **MUST** only modify files in temporary location.
    - When your wizard exits with code 0, files are copied from temporary location to config folder.

## General hooks

General hooks are **scripts** that have general usage eg. sendmail hook. Purpose of general hooks is that user can extend
functionality of his OpenVPN server quickly by copying hook to hook folder and edit settings on the top of the hook.

Hooks are located in `hook` directory. Please follow hook guidelines:

- File name: **hook_\<identifier\>**  
- At the top of the script
  - Optionaly copyright notice
  - What this hook does
  - Setttings with comments and an example settings values

**Note:** All hooks run as non-root user so instead of using `ip` and `iptables` use `ovpn-ip`, `ovpn-iptables`, `ovpn-ip6tables` (see [/root/usr/local/sbin](/usr/local/sbin)).
