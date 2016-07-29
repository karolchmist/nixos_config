# Home Nixos Configuration

Installing Nixos for UEFI

## Prepare USB

Install unetbootin, install iso to usb
Install mtools, run 
sudo mlabel -i /dev/sdb1 -s ::"NIXOS_ISO  "       


## Installation

systemctl start display-manager

Run gparted
Create GPT partition table

Create 100MiB of partition of fat32, put "boot" flag on it, label it "boot".

Create the rest for linux, label it "nixos".

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
