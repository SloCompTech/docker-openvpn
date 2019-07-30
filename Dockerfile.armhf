#
# Base image
# @see https://github.com/SloCompTech/docker-baseimage
#
FROM slocomptech/baseimage:alpine-armhf

# Build arguments
ARG BUILD_DATE
ARG VCS_REF
ARG VCS_SRC
ARG VERSION

# 
# Image labels
# @see https://github.com/opencontainers/image-spec/blob/master/annotations.md
# @see http://label-schema.org/rc1/
# @see https://semver.org/
#
LABEL org.opencontainers.image.title="OpenVPN Server" \
      org.label-schema.name="OpenVPN Server" \
      org.opencontainers.image.description="Docker image with OpenVPN server" \
      org.label-schema.description="Docker image with OpenVPN server" \
      org.opencontainers.image.url="https://github.com/SloCompTech/docker-openvpn" \
      org.label-schema.url="https://github.com/SloCompTech/docker-openvpn" \
      org.opencontainers.image.authors="Martin Dagarin <martin.dagarin@gmail.com>" \
      org.opencontainers.image.version=$VERSION \
      org.label-schema.version=$VERSION \
      org.opencontainers.image.revision=$VCS_REF \
      org.label-schema.vcs-ref=$VCS_REF \
      org.opencontainers.image.source=$VCS_SRC \
      org.label-schema.vcs-url=$VCS_SRC \
      org.opencontainers.image.created=$BUILD_DATE \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.schema-version="1.0"


#
# Environment variables
# @see https://github.com/OpenVPN/easy-rsa/blob/master/doc/EasyRSA-Advanced.md
#
ENV EASYRSA=/usr/share/easy-rsa \
    EASYRSA_PKI=/config/pki \
    EASYRSA_VARS_FILE=/config/ssl/vars \
    #EASYRSA_SSL_CONF=/config/ssl/openssl-easyrsa.cnf \
    EASYRSA_SAFE_CONF=/config/ssl/safessl-easyrsa.cnf \
    EASYRSA_TEMP_FILE=/config/tmp/temp \
    TUNNEL_INTERFACE="tun0"

# Install packages
RUN apk add --no-cache \
    # Core packages
    bash \
    easy-rsa \
    iptables \
    ip6tables \
    openvpn \
    python3 \
    sudo && \
    # Link easy-rsa in bin directory
    ln -s ${EASYRSA}/easyrsa /usr/local/bin && \
    # Link python3 also as python
    ln -s /usr/bin/pip3 /usr/bin/pip && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    # Remove any temporary files created by apk
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/* && \
    # Add permission for network management to user abc
    echo "${CONTAINER_USER} ALL=(ALL) NOPASSWD: \
      /sbin/ip, \
      /sbin/ip6tables, \
      /sbin/ip6tables-compat, \
      /sbin/ip6tables-compat-restore, \
      /sbin/ip6tables-compat-save, \
      /sbin/ip6tables-restore, \
      /sbin/ip6tables-restore-translate, \
      /sbin/ip6tables-save, \
      /sbin/ip6tables-translate, \
      /sbin/iptables, \
      /sbin/iptables-compat, \
      /sbin/iptables-compat-restore, \
      /sbin/iptables-compat-save, \
      /sbin/iptables-restore, \
      /sbin/iptables-restore-translate, \
      /sbin/iptables-save, \
      /sbin/iptables-translate, \
      /sbin/route" \
      >> /etc/sudoers.d/${CONTAINER_USER}

# Add repo files to image
COPY root/ /
