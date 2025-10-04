{
  description = "Custom dwl build with config.h/patches";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # pulls dwl upstream repo, flake.lock will pin commit automatically
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
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        pname = "dwl";
        version = "git";

        src = dwl-src;

        nativeBuildInputs = [ pkgs.pkg-config ];
        buildInputs = [ pkgs.wlroots pkgs.libxkbcommon ];

        postPatch = ''
          cp ${./config.h} config.h
          # If you have patches:
          # patch -p1 < ${./gaps.diff}
        '';

        installPhase = ''
          mkdir -p $out/bin
          cp dwl $out/bin/
        '';
      };
    };
}
