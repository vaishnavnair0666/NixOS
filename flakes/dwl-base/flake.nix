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
        ];

        # preBuild = ''
        #   		echo "Current dir"
        #   		pwd
        #   		echo "Files "
        #   		ls -l
        #   		cp ${./config.h} $PWD/config.h
        #   		echo "files after copy"
        #   		ls -l
        #             # [ -f ${./config.h} ] && cp ${./config.h} $PWD/config.h
        # '';
        #
        # buildPhase = ''
        #   make 
        # '';
        buildPhase = ''
          echo "Building DWL..."
          make
          echo "Overwriting with custom config.h"
          cp ${./config.h} config.h
          make clean
          make
        '';

        installPhase = ''
                    mkdir -p $out/bin
                    cp dwl $out/bin/

                    mkdir -p $out/share/wayland-sessions
                    echo '[Desktop Entry]
          Name=dwl
          Comment=Dynamic Wayland Window Manager
          Exec=$out/bin/dwl
          Type=Application
          ' > $out/share/wayland-sessions/dwl.desktop
        '';
      };

      defaultPackage = self.packages.dwl;
    };
}
