{ pkgs, ... }:

{
  plugins.treesitter = {
    enable = true;
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      bash
      json
      lua
      make
      markdown
      javascript
      typescript
      tsx
      css
      html
      svelte
      vue
      nix
      regex
      toml
      vim
      vimdoc
      xml
      yaml
      rust
      java

      c
      cpp
    ];
    indent.enable = true;
  };
  plugins.treesitter-context = {
    enable = true;
    settings = {
      multiline_threshold = 4;
      trim_scope = "outer";
    };
  };
  plugins.treesitter-refactor = {
    enable = true;
    settings = {
      highlight_definitions = {
        enable = true;
      };
      highlight_current_scope = {
        enable = false;
      };
      smart_rename = {
        enable = true;
        keymaps = {
          smart_rename = "grr";
        };
      };
      navigation = {
        enable = true;
        keymaps = {
          goto_definition = "gnd";
          list_definitions = "gnD";
        };
      };
    };
  };
  plugins.trim = {
    enable = true;
  };
  plugins.ts-autotag = { enable = true; };
  plugins.ts-context-commentstring.enable = true;

}
