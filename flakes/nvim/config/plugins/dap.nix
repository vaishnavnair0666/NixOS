{ ... }: {

  plugins = {
    dap = {
      enable = true;
      signs = {
        dapBreakpoint = {
          text = "●";
        };
        dapBreakpointCondition = {
          text = "◆";
        };
        dapStopped = {
          text = "▶";
        };
      };
      adapters = {
        lldb = {
          __raw = ''
            {
              type = "executable",
              command = "lldb-dap",
              name = "lldb"
            }
          '';
        };
      };
      configurations = {
        cpp = [
          {
            name = "Launch";
            type = "lldb";
            request = "launch";
            program = {
              __raw = ''
                function()
                  return vim.fn.input(
                    "Path to executable: ",
                    vim.fn.getcwd() .. "/",
                    "file"
                  )
                end
              '';
            };
            cwd = "\${workspaceFolder}";
            stopOnEntry = false;
            args = [ ];
          }
        ];
      };
    };
    dap-ui = {
      enable = true;

      settings = {
        expandLines = true;

        icons = {
          expanded = "▾";
          collapsed = "▸";
          currentFrame = "▸";
        };

        controls = {
          enabled = true;
          element = "repl";
          icons = {
            pause = "⏸";
            play = "▶";
            stepInto = "⏎";
            stepOver = "⏭";
            stepOut = "⏮";
            stepBack = "b";
            runLast = "▶▶";
            terminate = "⏹";
          };
        };

        layouts = [
          {
            elements = [
              { id = "scopes"; size = 0.25; }
              { id = "breakpoints"; size = 0.25; }
              { id = "stacks"; size = 0.25; }
              { id = "watches"; size = 0.25; }
            ];
            size = 40;
            position = "left";
          }
          {
            elements = [
              { id = "repl"; size = 0.5; }
              { id = "console"; size = 0.5; }
            ];
            size = 10;
            position = "bottom";
          }
        ];

        floating = {
          maxHeight = 0.9;
          maxWidth = 0.5;
          border = "single";
          mappings = {
            close = [ "q" "<Esc>" ];
          };
        };

        windows = {
          indent = 1;
        };

        render = {
          maxTypeLength = 50;
          maxValueLines = 100;
        };
      };
    };
    dap-virtual-text = {
      enable = true;
    };
  };
  extraConfigLua = ''
    local dap = require("dap")
    local dapui = require("dapui")

    dap.listeners.after.event_initialized["dapui"] = function()
      dapui.open()
    end

    dap.listeners.before.event_terminated["dapui"] = function()
      dapui.close()
    end

    dap.listeners.before.event_exited["dapui"] = function()
      dapui.close()
    end
  '';
}
