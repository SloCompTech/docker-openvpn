#!/usr/bin/with-contenv bash
#
# CRL update
#

[ -n "$NO_CRL_UPDATE" ] || [ ! -d "$EASYRSA_PKI" ] || ovpn pki crl
