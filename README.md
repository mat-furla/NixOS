<a>
    <img src="logo.svg" alt="logo" title="nix-os" align="right" height="40" />
</a>

Dotfiles - NixOS
======================

# Introduction

NixOS is a Linux distribution built on top of the Nix package manager. It uses declarative configuration, allows reliable system upgrades and has tools dedicated to DevOps and deployment tasks.



# Installation

## Write image to USB

```sh
>> sudo cp /home/matheus/Downloads/nixos.iso  /dev/sda
```

## Partitioning

Optional clean previous filesystem:

```sh
>> sudo wipefs -a /dev/sda
```

Create partitions:

```sh
>> parted /dev/sda -- mklabel gpt
>> parted /dev/sda -- mkpart ESP fat32 1MiB 513MiB
>> parted /dev/sda -- set 1 boot on
>> parted /dev/sda -- mkpart primary 513MiB 100%
```

## Encryption

Setup LUKS on sda2 using `crypted` as label:

```sh
>> sudo cryptsetup luksFormat /dev/sda2
>> sudo cryptsetup luksOpen /dev/sda2 crypted
```

Create volume group and logical volumes for root and swap:

```sh
>> sudo pvcreate /dev/mapper/crypted
>> sudo vgcreate vg /dev/mapper/crypted
>> sudo lvcreate -L 8G -n swap vg
>> sudo lvcreate -l '100%FREE' -n nixos vg
```

## Format

```sh
>> sudo mkfs.fat -F 32 -n boot /dev/sda1
>> sudo mkfs.ext4 -L nixos /dev/vg/nixos
>> sudo mkswap -L swap /dev/vg/swap
```

## Mount

```sh
>> sudo mount /dev/disk/by-label/nixos /mnt
>> sudo mkdir -p /mnt/boot
>> sudo mount /dev/disk/by-label/boot /mnt/boot
>> sudo swapon /dev/vg/swap
```

Expected end result:

```sh
>> lsblk
NAME           MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
sda              8:0    0 232,9G  0 disk
├─sda1           8:1    0   512M  0 part  /mnt/boot
└─sda2           8:2    0 232,4G  0 part
  └─crypted    254:0    0 232,4G  0 crypt
    ├─vg-swap  254:1    0     8G  0 lvm   [SWAP]
    └─vg-nixos 254:2    0 224,4G  0 lvm   /mnt
```

## Configuration

Install `git` and clone repository

```sh
>> sudo nix-shell -p git
>> sudo git clone http://github.com/mat-furla/NixOS.git /mnt/etc/nixos
```

Create link for desired host:

```sh
>> ln -s /mnt/etc/nixos/hosts/${CURRENT-HOST} /mnt/etc/nixos/configuration.nix
```

Get current UUID's:

```sh
>> lsblk --fs
NAME           FSTYPE      FSVER    LABEL UUID                                   FSAVAIL FSUSE% MOUNTPOINT
sda
├─sda1         vfat        FAT32    boot  D646-CA7B                               476,3M     7% /boot
└─sda2         crypto_LUKS 2              70382127-d3e9-4265-b012-5041a586e58c
  └─crypted    LVM2_member LVM2 001       BtitPr-f7c5-gPJp-twS0-1qRL-18dD-lIDNTp
    ├─vg-swap  swap        1        swap  2a30e463-c302-4e9d-9b1a-faccf6581853                  [SWAP]
    └─vg-nixos ext4        1.0      nixos 2b1dc5f8-9e7e-4ca9-9bb6-19e656ac1ec4    201,7G     3% /
```

Edit `configuration.nix` to correspond with current layout:

```sh
>> sudo nano /etc/nixos/configuration.nix
```

```sh
boot.initrd.luks.devices = {
  crypted = {
    device = "/dev/disk/by-uuid/70382127-d3e9-4265-b012-5041a586e58c";
    preLVM = true;
    allowDiscards = true;
  };
};

fileSystems."/" = {
  device = "/dev/disk/by-uuid/2b1dc5f8-9e7e-4ca9-9bb6-19e656ac1ec4";
  fsType = "ext4";
};

fileSystems."/boot" = {
  device = "/dev/disk/by-uuid/D646-CA7B";
  fsType = "vfat";
};

swapDevices = [{
  device = "/dev/disk/by-uuid/2a30e463-c302-4e9d-9b1a-faccf6581853";
}];
```

## Install

```sh
>> sudo nixos-install
```

## Finalize

Set password and correct rights to /etc/nixos for your user:

```sh
>> sudo passwd matheus
>> sudo chown 1000:1000 /mnt/etc/nixos
```

Reboot system:

```sh
>> sudo reboot
```




# Troubleshooting

If the system doesn't boot, go back to the installation environment by booting from the installation media and remount all partitions:

```sh
>> cryptsetup luksOpen /dev/sda2 enc-pv
>> lvchange -a y /dev/vg/swap
>> lvchange -a y /dev/vg/nixos
>> mount /dev/vg/nixos /mnt
>> mount /dev/sda1 /mnt/boot
>> swapon /dev/vg/swap
>> nmtui
```




# NixOS Operations

## Install packages after change in configuration

```sh
sudo nix-store --verify --check-contents
```

## Optimize nix store to relink and remove duplicated

```sh
sudo nix-store --optimise -v
```

## Garbage collection

```sh
sudo nix-collect-garbage
```

## Garbage collection remove from history

```sh
sudo nix-collect-garbage -d
```

## Find packages

```sh
nix-env -qaP '.*emacs.*'
```

## File description

```sh
nix-env -qa --description '.*emacs.*'
```

## Show files installed by the package

```sh
readlink -f $(which nvim)
du -a /nix/store/72q6z4wy5bz9j7q4wbblig0cdm6j2n5w-neovim-0.3.8/bin/nvim
```

## Verify all installed packages

```sh
sudo nix-store --verify --check-contents
```

## Fix packages with failed checksums

```sh
sudo nix-store --verify --check-contents --repair
```

## List package dependencies

```sh
nix-store --query --requisites $(readlink -f /run/current-system)
nix-store -q --tree /nix/var/nix/profiles/system

nix-store --query --references\
  $(nix-instantiate '<nixpkgs>' -A emacs)
```




# References

 - Manual: https://nixos.org/nixos/manual/index.html#sec-installation
 - Manual Encryption 1: https://nixos.wiki/wiki/Full_Disk_Encryption
 - Manual Encryption 2: https://gist.github.com/martijnvermaat/76f2e24d0239470dd71050358b4d5134
 - Manual Encryption 3: https://gist.github.com/walkermalling/23cf138432aee9d36cf59ff5b63a2a58
 - Idempotent-desktop: https://github.com/ksevelyar/idempotent-desktop