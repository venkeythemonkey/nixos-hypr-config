{ nixpkgs-unstable, pkgs, ... }:

{
  imports = [
    "${nixpkgs-unstable}/nixos/modules/programs/wayland/noctalia.nix"
  ];

  programs.noctalia = {
    enable = true;
    package = pkgs.unstable.noctalia;
    recommendedServices.enable = true;
  };
}
