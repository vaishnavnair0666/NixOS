{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    niri
    alacritty
    bemenu
    cliphist
    foot
    grim
    mako
    udiskie
    slurp
    swappy
    swww
    waybar
    wayland
    wayland-protocols
    wl-clipboard
  ];
}

