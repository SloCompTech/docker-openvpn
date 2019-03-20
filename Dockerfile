#
# Base image
# @see https://github.com/linuxserver/docker-baseimage-alpine
# @see https://github.com/linuxserver/docker-baseimage-alpine-python3
#
FROM lsiobase/alpine.python3:latest

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
LABEL   org.opencontainers.image.title="OpenVPN Server" \
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
ENV PATH="/app/bin:$PATH" \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=0 \
    EASYRSA=/usr/share/easy-rsa \
    EASYRSA_PKI=/config/pki \
    EASYRSA_VARS_FILE=/config/ssl/vars \
    #EASYRSA_SSL_CONF=/config/ssl/openssl-easyrsa.cnf \
    EASYRSA_SAFE_CONF=/config/ssl/safessl-easyrsa.cnf \
    EASYRSA_TEMP_FILE=/config/temp \
    OVPN_ROOT=/config \
    OVPN_HOOKS=/config/hooks \
    OVPN_RUN=system.conf

# Install packages
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/main/" >> /etc/apk/repositories && \
    apk add --no-cache \
    # Core packages
    bash sudo iptables git openvpn easy-rsa && \
    # Link easy-rsa in bin directory
    ln -s ${EASYRSA}/easyrsa /usr/local/bin && \
    # Link python3 also as python
    ln -s /usr/bin/python3 /usr/bin/python && \
    # Remove any temporary files created by apk
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/* && \
    # Add permission for network management to user abc
    echo "abc ALL=(ALL) NOPASSWD: /sbin/ip, /sbin/iptables" >> /etc/sudoers

# Add repo files to image
COPY root/ /

# Configure
RUN chmod +x /app/bin/* && \
    chmod +x /usr/local/sbin/* && \
    chmod -R 0644 /etc/logrotate.d
