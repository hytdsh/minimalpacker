mkdir vboxadd
sudo mount -o loop VBoxGuestAdditions.iso vboxadd
sudo vboxadd/VBoxLinuxAdditions.run --nox11
sudo umount vboxadd
rmdir vboxadd

