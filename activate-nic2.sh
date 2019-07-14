# VirtualBox's "--nic2" is shown as "enp0s8" on Linux.
cat >~/enp0s8 <<[EOF]
allow-hotplug enp0s8
iface enp0s8 inet dhcp
[EOF]

sudo cp ~/enp0s8 /etc/network/interfaces.d/enp0s8
rm ~/enp0s8

# ifup@"enp0s8" is not from filename "/etc/network/interfaces.d/enp0s8".
# It's the DEVICE name from "ip link show" or "systemctl -a" or so.
sudo systemctl restart ifup@enp0s8
