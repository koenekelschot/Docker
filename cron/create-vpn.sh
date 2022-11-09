# Create VPN adapter
# runs when NAS boots
# shellcheck disable=SC2148

# https://petestechblog.com/2020/10/04/how-to-run-transmission-using-openvpn-in-docker-on-a-synology-nas-dsm-6-0/
# Create the necessary file structure for /dev/net/tun
if [ ! -c /dev/net/tun ]; then
    if [ ! -d /dev/net ]; then
        mkdir -m 755 /dev/net
    fi
    mknod /dev/net/tun c 10 200
fi
 
# Load the tun module if not already loaded
if ( ! (lsmod | grep -q "^tun\s") ); then
    insmod /lib/modules/tun.ko
fi