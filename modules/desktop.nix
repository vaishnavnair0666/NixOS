{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wayland
    wayland-protocols
    alacritty
    foot
    bemenu
    mako
    grim
    slurp
    swappy
    wl-clipboard
    cliphist
  ];
}

