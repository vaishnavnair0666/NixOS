{ ... }:

{
  plugins.oil = {
    enable = true;

    settings = {
      default_file_explorer = false;
      skip_confirm_for_simple_edits = true;

      view_options = {
        show_hidden = true;
      };

      float = {
        padding = 2;
        max_width = 90;
        max_height = 30;
        border = "rounded";
      };

      win_options = {
        signcolumn = "yes";
        number = false;
        relativenumber = true;
      };
    };
  };


}

