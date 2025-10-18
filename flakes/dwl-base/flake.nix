{
  description = "Wayland-only dwl with custom config.h and patches";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    dwl-src = {
      url = "git+https://codeberg.org/dwl/dwl.git?ref=main";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, dwl-src, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.dwl = pkgs.stdenv.mkDerivation {
        pname = "dwl";
        version = "custom";
        src = dwl-src;
        dontStrip = true;

        nativeBuildInputs = [ pkgs.pkg-config pkgs.wayland-scanner ];
        buildInputs = [
          pkgs.wlroots
          pkgs.wayland
          pkgs.wayland-protocols
          pkgs.libinput
          pkgs.libxkbcommon
          pkgs.pixman
          pkgs.xwayland
        ];
        makeFlags = [ "XWAYLAND=1" ];
        buildPhase = ''
          echo "Overwriting with custom config.h"
          cp ${./config.h} config.h
          make
        '';

        installPhase = ''
            install -Dm755 dwl $out/bin/dwl
            install -Dm644 /dev/stdin $out/share/wayland-sessions/dwl.desktop <<EOF
          [Desktop Entry]
          Name=dwl
          Comment=Dynamic Wayland Window Manager
          Exec=$out/bin/dwl
          Type=Application
          EOF
        '';
      };

      defaultPackage = self.packages.dwl;
    };
}
