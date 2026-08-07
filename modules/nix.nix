{ ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable the modern Nix CLI and flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.nh = {
    enable = true;
    flake = "/home/venkatesh/nixos-hypr-config";
  };
}
