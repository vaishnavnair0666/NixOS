{ pkgs, inputs, ... }:
let
  # alias for readability
  elephantPkg = inputs.elephant.packages.${pkgs.system}.default;
  walkerPkg = inputs.walker.packages.${pkgs.system}.default;
in {
  # Install both packages
  environment.systemPackages = [ elephantPkg walkerPkg ];

  imports = [ inputs.walker.nixosModules.walker ];

  nix.settings = {
    extra-substituters =
      [ "https://walker.cachix.org" "https://walker-git.cachix.org" ];

    extra-trusted-public-keys = [
      "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
      "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
    ];
  };
  # Autostart Elephant as a daemon via user service
  systemd.user.services.elephant = {
    description = "Elephant providers daemon";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      ExecStart = "${elephantPkg}/bin/elephant daemon";
      Restart = "on-failure";
      RestartSec = "2s";
    };
  };

  # Launch Walker as a GApplication service
  systemd.user.services.walker = {
    description = "Walker launcher service";
    wantedBy = [ "default.target" ];
    after = [ "elephant.service" ];
    requires = [ "elephant.service" ];
    serviceConfig = {
      ExecStart = "${walkerPkg}/bin/walker --gapplication-service";
      Restart = "on-failure";
      RestartSec = "2s";
    };
  };

  # Set configuration for programs.walker (per the module)
  programs.walker = {
    enable = true;
    runAsService = true;

    config = {
      theme = "corporate";
      force_keyboard_focus = true;
      placeholders."default" = {
        input = "Search";
        list = "No Results";
      };

      # prefix definitions
      providers.prefixes = [
        {
          provider = "websearch";
          prefix = "+";
        }
        {
          provider = "providerlist";
          prefix = "_";
        }
        {
          provider = "runner";
          prefix = ">";
        }
        {
          provider = "desktopapplications";
          prefix = "";
        } # default
      ];

      keybinds = {
        quick_activate = [ "F1" ];
        close = [ "Escape" ];
        next = [ "Down" ];
        previous = [ "Up" ];
        resume_last_query = [ "ctrl r" ];
      };
    };

    # You can override or add themes if needed
    themes = {
      corporate = {
        style = ''
          :root {
            --bg: #1e1e1e;
            --fg: #ffffff;
            --accent: #0a84ff;
            --radius: 8px;
          }
          body { background: var(--bg); color: var(--fg); font-family: "Inter", sans-serif; }
          input { border-radius: var(--radius); border: 2px solid var(--accent); }
        '';
      };
    };
  };
}
