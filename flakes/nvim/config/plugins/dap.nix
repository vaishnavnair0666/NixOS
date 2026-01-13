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
    };
    dap-ui = {
      enable = true;
    };
    dap-virtual-text = {
      enable = true;
    };
  };
}
