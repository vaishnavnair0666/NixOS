# overlays/elephant-overlay.nix
final: prev: {
  elephant = prev.callPackage (prev.fetchFromGitHub {
    owner = "abenz1267";
    repo = "elephant";
    rev = "master";
    sha256 = "uwcGPmie44rfq9qCOXO3WjJXiLxQxNPmKQYbG9a22/c=";
  }) { };
}
