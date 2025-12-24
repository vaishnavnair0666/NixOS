{ ... }:

{
  plugins.toggleterm = {
    enable = true;

    settings = {
      direction = "float";
      shadeTerminals = false;
      startInInsert = true;
      closeOnExit = false;
      persistMode = true;

      floatOpts = {
        border = "curved";
        winblend = 0;
      };
    };
  };
}
