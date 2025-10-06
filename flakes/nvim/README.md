# NixVim Flake Setup

A modular, reproducible Neovim configuration built using **Nix**, **Home Manager**. This setup focuses on performance, clarity, and maintainability.

------------------------------------------------------------------------

## Overview

This configuration includes:

-   **NixVim** for declarative Neovim setup\
-   **Home Manager** integration\
-   **Telescope** for fuzzy finding and live grep\
-   **Trouble** for diagnostics management\
-   **Flash** for fast in-buffer navigation\
-   **Aerial** for LSP symbols outline\
-   **Noice** for message UI improvements\
-   **Which-Key** for discoverable keybindings\
-   **Dashboard** for startup screen\
-   **LSP + CMP** for code intelligence and autocompletion\
-   **Conform** for formatting\
-   **Bufferline** for buffer/tab management\
-   **Neo-tree** for file explorer\
-   **Git integrations** via Telescope pickers

------------------------------------------------------------------------

## Directory Structure


    flake.nix
    ├── modules/
    │   ├── keymaps.nix
    │   ├── plugins/
    │   │   ├── cmp.nix
    │   │   ├── lsp.nix
    │   │   ├── dashboard.nix
    │   │   ├── formatters.nix
    │   │   ├── notify.nix
    │   │   ├── ui.nix
    │   │   └── which-key.nix
    └── home.nix

------------------------------------------------------------------------

## Telescope Keybindings

  ---------------------------------------------------------------------------------
  Key            Action                        Description
  -------------- ----------------------------- ------------------------------------
  `<leader>ff`   `find_files`                  Search files in current directory

  `<leader>fg`   `live_grep`                   Search text in project

  `<leader>fb`   `buffers`                     Show open buffers

  `<leader>fo`   `oldfiles`                    Recently opened files

  `<leader>fc`   `current_buffer_fuzzy_find`   Fuzzy search within current buffer

  `<leader>fh`   `help_tags`                   Search help topics

  `<leader>fm`   `marks`                       List marks

  `<leader>fq`   `quickfix`                    View quickfix list

  `<leader>fr`   `resume`                      Resume last Telescope picker

  `<leader>fd`   `diagnostics`                 Show diagnostics list

  `<leader>ch`   `command_history`             Command history

  `<leader>km`   `keymaps`                     Show key mappings

  `<leader>fs`   `symbols`                     List LSP symbols
  ---------------------------------------------------------------------------------

------------------------------------------------------------------------

## Git Integration

  Key            Action           Description
  -------------- ---------------- ----------------------------
  `<leader>gc`   `git_commits`    View commit history
  `<leader>gb`   `git_branches`   Switch or create branches
  `<leader>gs`   `git_status`     Show git status
  `<leader>gS`   `git_stash`      Manage git stashes
  `<leader>gB`   `git_bcommits`   Commits for current buffer

------------------------------------------------------------------------

## Tools and Toggles

  ---------------------------------------------------------------------------------------
  Key            Action                                Description
  -------------- ------------------------------------- ----------------------------------
  `s`            Flash jump                            Jump to visible text

  `<leader>a`    AerialToggle                          Toggle symbols outline

  `<leader>xx`   TroubleToggle document_diagnostics    File diagnostics

  `<leader>xX`   TroubleToggle workspace_diagnostics   Workspace diagnostics

  `<leader>nn`   Noice                                 Open Noice message UI

  `<leader>nh`   NoiceHistory                          Show Noice message history

  `<leader>nd`   NoiceDismiss                          Dismiss all notifications
  ---------------------------------------------------------------------------------------

------------------------------------------------------------------------

## Buffer Management

  Key                           Action
  ----------------------------- --------------------------
  `<leader>bn`                  Next buffer
  `<leader>bp`                  Previous buffer
  `<leader>bd`                  Close current buffer
  `<leader>bo`                  Close other buffers
  `<leader>1`--`<leader>6`      Jump to buffer 1--6
  `<leader>bh` / `<leader>bm`   Move buffer left / right

------------------------------------------------------------------------

## File Explorer (Neo-tree)

  Key            Action
  -------------- ---------------------
  `<leader>ee`   Toggle Neo-tree
  `<leader>ef`   Focus Neo-tree
  `<leader>er`   Reveal current file

------------------------------------------------------------------------

## UI Toggles

  Key            Action
  -------------- -------------------------
  `<leader>un`   Toggle line numbers
  `<leader>ur`   Toggle relative numbers
  `<leader>uw`   Toggle word wrap
  `<leader>us`   Toggle spell check

------------------------------------------------------------------------

## Miscellaneous Telescope Pickers

  Key            Action             Description
  -------------- ------------------ -------------------------------
  `<leader>pt`   `planets`          View Telescope planets picker
  `<leader>ma`   `man_pages`        Open man pages
  `<leader>hl`   `highlights`       List highlight groups
  `<leader>se`   `search_history`   View search history
  `<leader>sp`   `spell_suggest`    Spell suggestions

------------------------------------------------------------------------

## Planned Additions

-   Themes (Catppuccin, Tokyonight, Kanagawa)
-   Statusline (Lualine or Heirline)
-   Treesitter (syntax and highlighting)
-   Mason (LSP, DAP, Linter installer)
-   Autopairs and Surround
-   Snippets via LuaSnip
-   Session management (persisted.nvim or auto-session)
-   Debugging (nvim-dap) UI improvemnets
-   Icons (nvim-web-devicons)
-   Lazy-loading improvements

------------------------------------------------------------------------

## Usage

### Build and Apply

``` bash
home-manager switch --flake .#<username>@<hostname>
```

### Update

``` bash
nix flake update
```

------------------------------------------------------------------------

## Notes

-   Leader key: `<Space>`
-   Non-leader mappings are minimized to avoid conflicts
-   Fully modular and reproducible through Nix
-   Modules can be disabled or extended individually in `modules/plugins/*.nix`

------------------------------------------------------------------------
