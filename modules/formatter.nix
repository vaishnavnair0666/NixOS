{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Lua formatter
    stylua

    # Nix formatter
    nixpkgs-fmt

    # JS/TS/Svelte/JSON/Markdown formatter
    nodePackages.prettier
  ];
}

