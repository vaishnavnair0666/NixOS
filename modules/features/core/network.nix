{...}: {
  flake.nixosModules.network = {...}: {
    networking.hostName = "nixos";
    networking.networkmanager.enable = true;
  };
}
