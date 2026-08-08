{ config, username, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable the modern Nix CLI and flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.nh = {
    enable = true;
    flake = "${config.users.users.${username}.home}/nixos-hypr-config";

    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 3 --keep-since 7d";
    };
  };
}
