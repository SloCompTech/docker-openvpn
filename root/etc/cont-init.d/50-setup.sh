#!/usr/bin/with-contenv bash

#
#   Setup /config directory
#

# Setup backup
if [ ! -e "/config/backup" ]; then
	mkdir /config/backup
  chown abc:abc /config/backup
fi

#
#   Setup openvpn directory
#

if [ ! -d "/config/openvpn" ]; then
  echo "Creating /config/openvpn"
  mkdir -p /config/openvpn
  chown abc:abc /config/openvpn
fi

# Check directories inside openvpn directory
OVPN_DIR=(ccd client config hooks)
for h in ${OVPN_DIR[@]}
do
	if [ ! -d "/config/openvpn/$h" ]; then
		echo "Creating /config/openvpn/$h"
		mkdir /config/openvpn/$h
    chown abc:abc /config/openvpn/$h
	fi
done

# Check hook directories
HOOKS_DIR=( \
  auth \
  client-connect \
  client-disconnect \
  down \
  finish \
  init \
  learn-address \
  route-pre-down \
  route-up \
  tls-verify \
  up \
  )
for h in "${HOOKS_DIR[@]}"; do
	if [ ! -d "/config/openvpn/hooks/$h" ]; then
		echo "Creating /config/openvpn/hooks/$h"
		mkdir /config/openvpn/hooks/$h
    chown abc:abc /config/openvpn/hooks/$h
	fi
done

#
#   Setup EasyRSA
#

if [ -d "/config/pki" ]; then
	# Create CRL file, if it can
	if [ ! -f "/config/pki/crl.pem" ]; then
		touch /config/pki/crl.pem
	fi
fi

if [ ! -d "/config/ssl" ]; then
	echo "Setting up /config/ssl"
	mkdir -p /config/ssl
  chown abc:abc /config/ssl
fi

if [ ! -e "$EASYRSA_VARS_FILE" ]; then
  #cp -R -u $EASYRSA/openssl-easyrsa.cnf $EASYRSA_SSL_CONF
	cp -R -u $EASYRSA/vars.example $EASYRSA_VARS_FILE
  chown abc:abc $EASYRSA_VARS_FILE
fi

# Setup tmp
if [ ! -e "/config/tmp" ]; then
	mkdir /config/tmp
  chown abc:abc /config/tmp
fi
