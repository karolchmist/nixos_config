# Home Nixos Configuration

Installing Nixos for UEFI

## Installation

```
# Partitions
gdisk /dev/sda
n, <enter>, <enter>, +100k,   EF02 => boot, /dev/sda1
n, <enter>, <enter>, +200m,   EF00 => efi, /dev/sda2
n, <enter>, <enter>, <enter>, 8300 => linux, /dev/sda3
w

# Format
mkfs.ext2 -L boot  /dev/sda2
mkfs.ext4 -L nixos /dev/sda3

fdisk -l 

# Mount
mount LABEL=nixos /mnt
mkdir /mnt/boot
mount LABEL=boot /mnt/boot

# Generate conf
nixos-generate-config --root /mnt
nano /mnt/etc/nixos/configuration.nix
nano /mnt/etc/nixos/hardware-configuration.nix

# Install
nixos-install
reboot
```
