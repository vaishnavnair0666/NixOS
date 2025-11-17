{ ... }: {
  programs.nixvim.plugins.ccc = {
    enable = true;
    settings = {
      highlighter = { auto_enable = true; };
      picker = {
        default_color = "#ffffff";
        format = "hex";
        # step config (exposed to ccc mappings via closures)
        step = {
          fine = 1; # used by Left/Right
          coarse = 10; # used by Shift+Left/Shift+Right
        };
      };
      mappings = {
        # navigation
        prev_slider = "k";
        next_slider = "j";
        slider_left = "<Left>";
        slider_right = "<Right>";

        # adjustments
        dec_fine = "<Left>";
        inc_fine = "<Right>";
        dec_coarse = "H"; # Shift+Left alternative
        inc_coarse = "L"; # Shift+Right alternative

        # alternate adjustment keys (vi-style)
        dec_large = "h";
        inc_large = "l";

        # format / mode
        next_format = "i";
        prev_format = "I";

        # accept / cancel
        accept = "<CR>";
        cancel = "q";
        close = "<Esc>";

        # extras
        eyedropper = "<A-p>"; # Alt-p to pick color from screen (if supported)
        copy_hex = "<A-c>"; # Alt-c to copy hex to clipboard
        paste_color = "<A-v>"; # Alt-v to paste color into picker

      };
    };
  };
}

