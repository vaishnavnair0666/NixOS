## Installation Guide: Setting Up with NixOS Minimal ISO

This section guides you through installing NixOS with Btrfs and EFI using my dotfiles. The instructions assume you’re starting from the NixOS minimal installer ISO and want a minimal, reproducible system.

### 1. Boot into the NixOS Minimal Installer

Download the latest NixOS minimal ISO from https://nixos.org/download.html and boot it (USB/DVD).

### 2. Partition the Disk (Replace /dev/sdX with your target disk)

Open a terminal and run:
```sh
cfdisk /dev/sdX
```
Create these partitions:
- EFI System Partition (512M, type EFI System)
- Linux Swap (size as needed, type Linux swap)
- Linux Filesystem (rest of disk, type Linux filesystem)

Suppose your layout is:
- /dev/sdX1 EFI
- /dev/sdX2 swap
- /dev/sdX3 root

### 3. Format the Partitions

```sh
mkfs.vfat -F 32 /dev/sdX1            # EFI partition
mkswap /dev/sdX2                     # Swap
mkfs.btrfs -f /dev/sdX3              # Root (Btrfs)
```

### 4. Create Btrfs Subvolumes (Optional but recommended)

```sh
mount /dev/sdX3 /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
umount /mnt
```

### 5. Mount the Filesystems

```sh
mount -o subvol=@ /dev/sdX3 /mnt
mkdir /mnt/home
mount -o subvol=@home /dev/sdX3 /mnt/home
mkdir /mnt/boot
mount /dev/sdX1 /mnt/boot
swapon /dev/sdX2
```

### 6. Generate the Basic NixOS Configuration

```sh
nixos-generate-config --root /mnt
```

### 7. Network Setup (if needed)

For wired: usually works out of the box.  
For Wi-Fi: use `iwctl` or `nmtui` to connect.

### 8. Clone Your Dotfiles

Make sure you have network access, then:
```sh
nix-shell -p git
git clone https://github.com/YOUR_GITHUB_USERNAME/.dotfiles /mnt/home/vaish/.dotfiles
```
> **Tip:** It’s recommended to fork my repo and use your fork, so you can track your own changes.

### 9. Replace the Hardware Configuration

It’s important to replace the hardware-configuration.nix in the dotfiles with the one generated for your hardware:
```sh
cp /mnt/etc/nixos/hardware-configuration.nix /mnt/home/vaish/.dotfiles/hardware-configuration.nix
```

### 10. Edit Configuration if Needed

Edit `/mnt/home/vaish/.dotfiles/configuration.nix` and update any paths or usernames if you use something other than `vaish`.

### 11. Install NixOS Using Your Dotfiles

Change into the dotfiles directory and install:
```sh
cd /mnt/home/vaish/.dotfiles
nixos-install --flake .#your-hostname
```
Replace `your-hostname` with whatever you set as your hostname in the configuration.

### 12. Reboot

```sh
reboot
```

---

## Why Use Your Own Fork?

- Hardware configuration is unique to your system.  
- Forking lets you keep your changes (hardware, users, secrets) separate from mine.
- You can safely pull updates from upstream without affecting your customizations.

---