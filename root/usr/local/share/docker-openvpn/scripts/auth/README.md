# Authentication script

This is sample *authentication script* for **auth-user-pass-verify** hook.

## Configuration

``` bash
cp auth.py /config/openvpn/hooks/auth

# Edit database name in copied auth.py script

# Add option to openvpn config
echo 'auth-user-pass-verify "/app/hook.sh auth"' >> /config/openvpn/include-server.conf
```

## Add user

``` bash
# Note: db file must end with .csv or .json
./adduser.py /config/openvpn/hooks/auth db.csv <username> <password>
```
