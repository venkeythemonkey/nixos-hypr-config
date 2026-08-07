{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    brightnessctl
    unstable.kitty
    xdg-user-dirs
  ];
}
