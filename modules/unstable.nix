{ nixpkgs-unstable, ... }:

{
  nixpkgs.overlays = [
    (final: _prev: {
      unstable = import nixpkgs-unstable {
        inherit (final) config;
        inherit (final.stdenv.hostPlatform) system;
      };
    })
  ];
}
