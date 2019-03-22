#!/bin/sh

set -u
set -e

# Add a console on tty1
if [ -e ${TARGET_DIR}/etc/inittab ]; then
    grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
	sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
fi

echo "Adding custom dhcpcd configuration(denyinterfaces usb0)"
cat << __EOF__ >> "${TARGET_DIR}/etc/dhcpcd.conf"
denyinterfaces usb0
__EOF__

chmod 0600 ssh_host_dsa_key
chmod 0600 ssh_host_ecdsa_key
chmod 0600 ssh_host_ed25519_key
chmod 0600 ssh_host_rsa_key
