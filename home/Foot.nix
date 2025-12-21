{ ... }:

{
  programs.foot = {
    enable = true;

    settings = {
      main = {
        shell = "bash";
        font = "JetBrainsMono Nerd Font:size=11";
        pad = "0x0";
      };

      scrollback = { lines = 10000; };

      cursor = {
        style = "block";
        blink = "yes";
      };

      mouse = { hide-when-typing = "yes"; };
      colors = { background = "122016"; };
    };
  };
}
