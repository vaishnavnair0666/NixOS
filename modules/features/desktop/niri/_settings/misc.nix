{
  lib,
  pkgs,
  ...
}: {
  hotkey-overlay = {skip-at-startup = null;};

  prefer-no-csd = null;

  screenshot-path = "${
    builtins.getEnv "HOME"
  }/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
  xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
}
