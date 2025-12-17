{ config, pkgs, lib, ... }:

with lib;

let defaultFragment = "";
in {
  # Option schema
  options.programs.niri = {
    enable =
      mkEnableOption "Enable Niri compositor user config + runtime helpers";

    animationsFragment = mkOption {
      type = types.str;
      default = defaultFragment;
      description = "KDL fragment for window animations";
    };

    inputFragment = mkOption {
      type = types.str;
      default = defaultFragment;
      description = "KDL fragment for niri inputs";
    };

    layoutFragment = mkOption {
      type = types.str;
      default = defaultFragment;
      description = "KDL fragment for layout (injected into niri/config.kdl).";
    };

    keybindsFragment = mkOption {
      type = types.str;
      default = defaultFragment;
      description =
        "KDL fragment with keybinds (injected into niri/config.kdl).";
    };

    windowrulesFragment = mkOption {
      type = types.str;
      default = defaultFragment;
      description =
        "KDL fragment with window rules (injected into niri/config.kdl).";
    };

    outputFragment = mkOption {
      type = types.str;
      default = defaultFragment;
      description = "KDL fragment with niri output";
    };

    startupFragment = mkOption {
      type = types.str;
      default = defaultFragment;
      description =
        "KDL fragment with spawn-at-startup entries (injected into niri/config.kdl).";
    };

    wallpaperPath = mkOption {
      type = types.nullOr types.str;
      default = null;
      description =
        "Optional path to wallpaper to set on startup (e.g. ~/.config/niri/wallpapers/default.png).";
    };

  };

  config = lib.mkIf config.programs.niri.enable (let cfg = config.programs.niri;
  in {
    xdg.configFile = {
      "niri/config.kdl".text = ''
        // Generated Niri configuration (home-manager module)
        ${cfg.animationsFragment}

        ${cfg.inputFragment}

        ${cfg.outputFragment}

        ${cfg.layoutFragment}

        ${cfg.keybindsFragment}

        ${cfg.windowrulesFragment}

        ${cfg.startupFragment}


        hotkey-overlay {
          skip-at-startup
        }

        prefer-no-csd

        screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"
      '';

    };
  });
}
