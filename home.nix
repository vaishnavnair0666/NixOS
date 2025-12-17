{ ... }: {
  home.username = "vaish";
  home.homeDirectory = "/home/vaish";
  imports = [
    ./modules/niri/niri.nix
    ./home/Bash.nix
    ./home/Code-editor.nix
    ./home/Foot.nix
    ./home/Packages.nix
    ./home/Window-manager.nix
  ];

  # home.file.".config/hypr".source = ./config/hypr;
  home.file.".config/wofi".source = ./config/wofi;
  home.file.".config/waybar".source = ./config/waybar;

  #hello
  home.stateVersion = "25.11";
}

