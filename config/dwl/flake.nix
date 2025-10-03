{
  description = "Custom dwl flake with patches";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; };

  outputs = { self, nixpkgs, lib, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.${system} = {
        # dwl with patch applied
        dwl = pkgs.dwl.overrideAttrs (old: {
          pname = "dwl-custom";
          postPatch = ''
            cp ${./config.h} config.h
          '';
        });

        # dwl-msg
        dwl-msg = pkgs.stdenv.mkDerivation {
          pname = "dwl-msg";
          version = "git";

          src = pkgs.fetchgit {
            url = "https://codeberg.org/dwl/dwl.git";
            # no rev, will use flake.lock to pin automatically
            sha256 = lib.fakeSha256;
          };

          nativeBuildInputs = [ pkgs.pkg-config ];
          buildInputs = [ pkgs.wlroots pkgs.xorg.libxcb ];

          buildPhase = ''
            cd contrib/dwl-msg
            make
          '';

          installPhase = ''
            mkdir -p $out/bin
            cp dwl-msg $out/bin/
          '';
        };
      };
      # Export modules for nixos
      nixosModules = {
        default = { pkgs, ... }: {
          environment.systemPackages =
            [ self.packages.${system}.dwl self.packages.${system}.dwl-msg ];
        };
      };
      defaultPackage.${system} = self.packages.${system}.dwl;
    };
}
