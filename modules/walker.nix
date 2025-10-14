{ config, pkgs, lib, inputs, ... }:

{
  environment.systemPackages = [
    inputs.elephant.packages.${pkgs.system}.default
    inputs.walker.packages.${pkgs.system}.default
  ];

  nix.settings = {
    extra-substituters =
      [ "https://walker.cachix.org" "https://walker-git.cachix.org" ];

    extra-trusted-public-keys = [
      "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
      "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
    ];
  };

  # Walker reads configuration from:
  #   - $XDG_CONFIG_HOME/walker/config.toml (user)
  #   - or /etc/walker/config.toml (system)
  # So we use environment.etc to deploy a system-wide config file.
  environment.etc."walker/config.toml".text = ''
            	  theme = "corporate"         
            	  close_when_open = true          # close walker when invoking while already opened
            	  force_keyboard_focus = false
            	  click_to_close = true
            	  selection_wrap = true
            	  disable_mouse = false


            	  [shell]
            	  anchor_top = true
            		  anchor_bottom = false
            		  anchor_left = false
            		  anchor_right = true


            		  runAsService = true         # Runs Walker as a background daemon at startup

            		  [placeholders.default]
            		  input = "Search"            # Placeholder text for the input box
            			  list = "Example"            # Placeholder text for the result list

            			  [[providers.prefixes]]
            			  provider = "websearch"      # Enables built-in web search provider
            				  prefix = "+"                # Trigger with “+ <query>”

            				  [[providers.prefixes]]
            				  provider = "providerlist"   # Built-in provider listing all available providers
            					  prefix = "_"                # Trigger with “_”

            					  [keybinds]
            					  close = ["Escape"]                     # Closes Walker
            						  next = ["Down"]                        # Move selection down
            						  previous = ["Up"]                      # Move selection up
            						  toggle_exact = ["ctrl e"]              # Toggle fuzzy vs exact search
            						  resume_last_query = ["ctrl r"]         # Reopen Walker with previous query
            						  quick_activate = ["F1", "F2", "F3", "F4"]  # Open Walker directly

            						  [themes.corporate]
            						  style = '''
            							  :root {
            								  --bg: #1e1e1e;
            								  --fg: #ffffff;
            								  --accent: #0a84ff;
            								  --radius: 12px;
            							  }
              body {
            background: var(--bg);
            color: var(--fg);
            	   font-family: "Inter", sans-serif;
              }
              input {
            	  border-radius: var(--radius);
            border: 2px solid var(--accent);
              }
              '''
        [providers]
        default = [
          "desktopapplications",
          "calc",
          "runner",
          "menus",
          "websearch",
        ]
    empty = ["desktopapplications"]

            # These control the structure of Walker’s UI.
            	  [themes.corporate.layouts]
            	  layout = '''
            		  <layout>
            		  <input />
            		  <list />
            		  </layout>
            		  '''

            		  item_calc = '''
            		  <item>
            		  <title />
            		  <description />
            		  </item>
            		  '''
            		  '';

  systemd.user.services.elephant = {
    description = "Elephant layer-shell service";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart =
        "${inputs.elephant.packages.${pkgs.system}.default}/bin/elephant";
      Restart = "on-failure";
    };
  };

  systemd.user.services.walker = {
    description = "Walker Launcher Service";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${
          inputs.walker.packages.${pkgs.system}.default
        }/bin/walker --gapplication-service";
      Restart = "on-failure";
    };
  };

}
