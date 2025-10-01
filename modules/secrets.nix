{ config, pkgs, lib, ... }:

{
  # Configure sops-nix to know which age key to use for decryption
  sops = { age.keyFile = "/home/vaish/.config/sops/age/keys.txt"; };
}

