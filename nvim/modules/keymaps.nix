{ ... }: {
  programs.nixvim.keymaps =

    [
      # Flash
      {
        key = "s";
        action = "<cmd>lua require('flash').jump()<cr>";
        options.desc = "Flash jump";
      }

      # Aerial toggle
      {
        key = "<leader>a";
        action = "<cmd>AerialToggle!<cr>";
        options.desc = "Toggle symbols outline";
      }
      # Trouble diagnostics
      {
        key = "<leader>xx";
        action = "<cmd>TroubleToggle document_diagnostics<cr>";
        options.desc = "Document diagnostics";
      }
      {
        key = "<leader>xX";
        action = "<cmd>TroubleToggle workspace_diagnostics<cr>";
        options.desc = "Workspace diagnostics";
      }

      {
        key = "<leader>nn";
        action = "<cmd>Noice<cr>";
        options.desc = "Noice messages";
      }
      {
        key = "<leader>nh";
        action = "<cmd>NoiceHistory<cr>";
        options.desc = "Noice history";
      }
      {
        key = "<leader>nd";
        action = "<cmd>NoiceDismiss<cr>";
        options.desc = "Dismiss all notifications";
      }
    ];
}
