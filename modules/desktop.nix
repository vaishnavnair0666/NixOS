{ pkgs, ... }: {
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "dwl";
      user = "vaish";
    };
  };

  environment.systemPackages = with pkgs; [
    # waybar
    alacritty
    bemenu # dmenu-like launcher for Wayland
    swaybg # set background
    mako # notifications
    grim
    slurp
    swappy # screenshots
    wl-clipboard
    cliphist
  ];
}

