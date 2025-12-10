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

    barChoice = mkOption {
      type = types.str;
      default = "waybar";
      description = "Which bar to use: 'waybar', 'dms', or 'noctalia'.";
    };

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

  # Implementation — provide attributes only when enabled
  # (Do NOT read config.xdg.configFile or config.systemd.user.services)
  config = lib.mkIf config.programs.niri.enable (let
    cfg = config.programs.niri;

    niriPkgs = with pkgs; [
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

    # base service definitions (do not merge or read existing services)
    baseServices = {
      "xwayland-satellite" = {
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
        Install = { WantedBy = [ "graphical-session.target" ]; };
      };

      "xdg-desktop-portal" = {
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
          Environment = [ "XDG_CURRENT_DESKTOP=niri" ];
        };
        Install = { WantedBy = [ "graphical-session.target" ]; };
      };

      "xdg-desktop-portal-gnome" = {
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
        Install = { WantedBy = [ "graphical-session.target" ]; };
      };

      "xdg-desktop-portal-gtk" = {
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
        Install = { WantedBy = [ "graphical-session.target" ]; };
      };

      "wl-paste-cliphist" = {
        Unit = {
          Description = "wl-paste clipboard watcher (cliphist)";
          After = [ "graphical-session.target" ];
        };
        Service = {
          Type = "simple";
          ExecStart =
            "${pkgs.wl-clipboard}/bin/wl-paste --watch cliphist store";
          Restart = "on-failure";
          RestartSec = "2s";
        };
        Install = { WantedBy = [ "graphical-session.target" ]; };
      };

      "swww-daemon" = {
        Unit = {
          Description = "swww wallpaper daemon";
          After = [ "graphical-session.target" ];
        };
        Service = {
          Type = "simple";
          ExecStart = "${pkgs.swww}/bin/swww-daemon";
          Restart = "on-failure";
          RestartSec = "2s";
        };
        Install = { WantedBy = [ "graphical-session.target" ]; };
      };
    };

    # add bar/dms if requested
    servicesWithBar = baseServices // (if cfg.barChoice == "waybar" then {
      "waybar-niri" = {
        Unit = {
          Description = "Waybar (Niri session)";
          After = [ "graphical-session.target" ];
          PartOf = [ "graphical-session.target" ];
          ConditionEnvironment = "XDG_CURRENT_DESKTOP=niri";
        };
        Service = {
          Type = "simple";
          ExecStart = "${pkgs.waybar}/bin/waybar";
          Restart = "on-failure";
          RestartSec = "1s";
        };
        Install = { WantedBy = [ "graphical-session.target" ]; };
      };
    } else if cfg.barChoice == "dms" then {
      "dms-niri" = {
        Unit = {
          Description = "DMS shell (Niri session)";
          After = [ "graphical-session.target" ];
          PartOf = [ "graphical-session.target" ];
          ConditionEnvironment = "XDG_CURRENT_DESKTOP=niri";
        };
        Service = {
          Type = "simple";
          ExecStart = "${config.home.homeDirectory}/.local/bin/dms run";
          Restart = "on-failure";
        };
        Install = { WantedBy = [ "graphical-session.target" ]; };
      };
    } else
      { });

    # optionally append oneshot wallpaper applier
    finalServices = if cfg.wallpaperPath != null then
      servicesWithBar // {
        "swww-set-wallpaper" = {
          Unit = {
            Description = "Set wallpaper via swww once daemon is up";
            After = [ "swww-daemon.service" ];
          };
          Service = {
            Type = "oneshot";
            ExecStart = ''
              /bin/sh -c "sleep 5 && ${pkgs.swww}/bin/swww img '${cfg.wallpaperPath}' --transition 2 || true"
            '';
          };
          Install = { WantedBy = [ "graphical-session.target" ]; };
        };
      }
    else
      servicesWithBar;

  in {
    # install packages into the user profile
    home.packages = niriPkgs;

    # supply xdg config entries (module system will merge with other modules)
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

        environment {
          ${
            concatMapStringsSep "\n" (k: ''
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

      "xdg-desktop-portal/portals.conf".text = ''
        [preferred]
        default=gtk
        org.freedesktop.impl.portal.FileChooser=gtk
        org.freedesktop.impl.portal.Screenshot=gnome
        org.freedesktop.impl.portal.ScreenCast=gnome
      '';

      "xdg-desktop-portal/niri-portals.conf".text = ''
        [preferred]
        default=gtk
        org.freedesktop.impl.portal.FileChooser=gtk
        org.freedesktop.impl.portal.Screenshot=gnome
        org.freedesktop.impl.portal.ScreenCast=gnome
      '';
    };

    # systemd target and services (module merges these attrsets with others)
    systemd.user.targets = {
      "niri-session" = {
        Unit = {
          Description = "Niri compositor session";
          Documentation = "man:systemd.special(7)";
          Wants = [ "graphical-session-pre.target" ];
          After = [ "graphical-session-pre.target" ];
        };
      };
    };

    systemd.user.services = finalServices;
  });
}
