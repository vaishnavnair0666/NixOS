{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.programs.niri;

  # default fragments (empty string) users/hosts override by setting these options
  defaultFragment = "";
in {
  options.programs.niri = {
    enable =
      mkEnableOption "Enable Niri compositor user config + runtime helpers";

    # small surface to inject pieces that will be interpolated into config.kdl
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

    # choices / simple runtime options
    barChoice = mkOption {
      type = types.str;
      default = "waybar";
      description = "Which bar to use: 'waybar', 'dms', or 'noctalia'.";
    };

    # environment overrides: map of string -> string
    environment = mkOption {
      type = types.attrsOf types.str;
      default = {
        XDG_CURRENT_DESKTOP = "niri";
        XDG_SESSION_TYPE = "wayland";
        GTK_USE_PORTAL = "1";
        MOZ_ENABLE_WAYLAND = "1";
        QT_QPA_PLATFORM = "wayland";
        ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      };
      description =
        "Additional environment variables to write into niri/config.kdl (key/value).";
    };
  };

  config = mkIf cfg.enable {
    # Core runtime packages (install in user profile)
    home.packages = with pkgs; [
      niri
      udiskie
      xwayland-satellite
      swww
      grim
      slurp
      wl-clipboard
      swappy
      xdg-desktop-portal
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
      waybar
    ];

    # Niri KDL config generation (single source of truth)
    xdg.configFile."niri/config.kdl".text = ''
            // Generated Niri configuration (home-manager module)
            // Fragments injected from module options (layout, keybinds, windowrules, startup)
      ${cfg.animationsFragment}

      ${cfg.inputFragment}

      ${cfg.outputFragment}

      ${cfg.layoutFragment}

      ${cfg.keybindsFragment}

      ${cfg.windowrulesFragment}

      ${cfg.startupFragment}

      environment {
              ${
                lib.concatMapStringsSep "\n" (k: ''
                  ${k} "${cfg.environment.${k}}"
                '') (builtins.attrNames cfg.environment)
              }
            }

            hotkey-overlay {
              skip-at-startup
            }

            prefer-no-csd

            screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"
    '';

    # Portal preference files 
    xdg.configFile."xdg-desktop-portal/portals.conf".text = ''
      [preferred]
      default=gtk
      org.freedesktop.impl.portal.FileChooser=gtk
      org.freedesktop.impl.portal.Screenshot=gnome
      org.freedesktop.impl.portal.ScreenCast=gnome
    '';

    xdg.configFile."xdg-desktop-portal/niri-portals.conf".text = ''
      [preferred]
      default=gtk
      org.freedesktop.impl.portal.FileChooser=gtk
      org.freedesktop.impl.portal.Screenshot=gnome
      org.freedesktop.impl.portal.ScreenCast=gnome
    '';

    # Systemd user target for deterministic session ordering
    systemd.user.targets.niri-session = {
      Unit = {
        Description = "Niri compositor session";
        Documentation = "man:systemd.special(7)";
        Wants = [ "graphical-session-pre.target" ];
        After = [ "graphical-session-pre.target" ];
      };
    };

    # Waybar service (enabled only when requested)
    systemd.user.services."waybar-niri" = lib.mkIf (cfg.barChoice == "waybar") {
      Unit = {
        Description = "Waybar (Niri session)";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
        ConditionEnvironment = "XDG_CURRENT_DESKTOP=niri";
      };
      Service = {
        ExecStart = "${pkgs.waybar}/bin/waybar";
        Restart = "on-failure";
        RestartSec = "1s";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

    # DMS fallback when barChoice == "dms" (exec path can be overridden by users)
    systemd.user.services."dms-niri" = lib.mkIf (cfg.barChoice == "dms") {
      Unit = {
        Description = "DMS shell (Niri session)";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
        ConditionEnvironment = "XDG_CURRENT_DESKTOP=niri";
      };
      Service = {
        ExecStart = "${config.home.homeDirectory}/.local/bin/dms run";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

    # XWayland satellite service (supervise X11 support)
    systemd.user.services."xwayland-satellite" = {
      Unit = {
        Description = "XWayland satellite (for out-of-wayland X11 apps)";
        BindsTo = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        Type = "notify";
        NotifyAccess = "all";
        ExecStart = "${pkgs.xwayland-satellite}/bin/xwayland-satellite";
        StandardOutput = "journal";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

    # XDG Desktop Portal broker (ensure it binds to the correct WAYLAND_DISPLAY)
    systemd.user.services."xdg-desktop-portal" = {
      Unit = {
        Description = "XDG Desktop Portal broker";
        After = [ "graphical-session.target" "pipewire.service" ];
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        Type = "dbus";
        BusName = "org.freedesktop.portal.Desktop";
        ExecStart = "${pkgs.xdg-desktop-portal}/libexec/xdg-desktop-portal";
        Restart = "on-failure";
        Environment =
          [ "XDG_CURRENT_DESKTOP=niri" "WAYLAND_DISPLAY=wayland-1" ];
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

    systemd.user.services."xdg-desktop-portal-gnome" = {
      Unit = {
        Description = "XDG Desktop Portal - GNOME backend";
        After = [ "graphical-session.target" "pipewire.service" ];
        PartOf = [ "graphical-session.target" ];
        Requires = [ "pipewire.service" ];
      };
      Service = {
        Type = "dbus";
        BusName = "org.freedesktop.impl.portal.desktop.gnome";
        ExecStart =
          "${pkgs.xdg-desktop-portal-gnome}/libexec/xdg-desktop-portal-gnome";
        Restart = "on-failure";
        Environment = [ "XDG_CURRENT_DESKTOP=niri" ];
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

    systemd.user.services."xdg-desktop-portal-gtk" = {
      Unit = {
        Description = "XDG Desktop Portal - GTK backend";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        Type = "dbus";
        BusName = "org.freedesktop.impl.portal.desktop.gtk";
        ExecStart =
          "${pkgs.xdg-desktop-portal-gtk}/libexec/xdg-desktop-portal-gtk";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
