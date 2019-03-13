# Examples

Here are located examples how to configure your OpenVPN server and hooks.

## Copyright & author notice on example

If you care copyright of your contributed material, put JavaDoc style notice in the begining of the file.

``` bash
#
# Script that ... SHORT DESCRIPTIO
# @author <name>
# @version <version>
# @since <date in DD/MM/YYYY format>
#
```

## Config examples

Config examples are located in `config` directory. Each subdirectory represents one example.  

Config directory has following structure:  

```
config
    <example name> # Directory with your examples
        client # Directory, OpenVPN client config files
            <name>.conf # Partial OpenVPN client config file
        server # Directory, OpenVPN server config files
            <name>.conf # Partial OpenVPN server config file
        hooks # Directory with hooks for this example
            <hook name> # Directory, name of hook
                <scripts> # Executable scripts
        wizard # Setup script, run on `ovpn_enconf` command.
        Readme.md # Info about example, what to configure
```

### Notes

- **DO NOT** use `dev` attribute, because it is set to static interface `tun0`.
- **DO NOT** use any script running directives, because they are probably already set in `system.conf` (except `auth-user-pass-verify` is commented out), but use hooks directory.
- **DO NOT** use log directives, because they are already set for `log` directory.

### Wizard

Wizard is script that helps user to simply configure your example to his needs.
User will call `ovpn_enconf CONFIG_NAME [wizard args]` to load your example in server config.  

Then there are to options:

1. User manualy configure settigns in `/config/openvpn` folder
2. Your **wizard** script, configures files in `/config/openvpn`
    - Configuration files are copied to temporary location (so they can be modified)
    - `wizard` script will be called with temporary location as first argument (folder has same structure as in examples)

## General hooks

General hooks are **scripts** that have general usage eg. sendmail hook. Purpose of general hooks is that user can extend
functionality of his OpenVPN server quickly by copying hook to hook folder and edit settings on the top of the hook.

Hooks are located in `hook` directory. Please follow hook guidelines:

- File name: **hook_\<identifier\>**  
- At the top of the script
    - Optionaly copyright notice
    - What this hook does
    - Setttings with comments and an example settings values