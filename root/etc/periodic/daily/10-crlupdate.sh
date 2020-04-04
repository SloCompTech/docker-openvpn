#!/usr/bin/with-contenv bash
#
# CRL update
#

[ -n "$NO_CRL_UPDATE" ] || ovpn pki crl
