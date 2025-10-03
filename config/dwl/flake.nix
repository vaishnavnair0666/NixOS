{
  description = "Custom dwl flake with patches";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    dwlUpstream.url = "git+https://codeberg.org/dwl/dwl.git?ref=main";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
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

          src = inputs.dwlUpstream;
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
