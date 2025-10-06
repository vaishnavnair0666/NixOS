{ ... }: {
  programs.nixvim.plugins = {

    # REST API testing
    rest.enable = true;
    # Testing
    neotest = {
      enable = true;
      adapters = {
        # JS/TS adapter
        jest.enable = true;
        # Svelte/Playwright → handled via vitest adapter if you need
        vitest.enable = true;
      };
    };
  };
}
