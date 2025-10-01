{ config, pkgs, ... }:

{
  users.users.vaish = {
    isNormalUser = true;
    extraGroups =
      [ "wheel" "networkmanager" "audio" "video" "input" "bluetooth" ];
  };
}

