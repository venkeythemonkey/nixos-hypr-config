{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    brightnessctl
    grim
    libnotify
    playerctl
    unstable.hyprland-qtutils
    unstable.kitty
    xdg-user-dirs
  ];
}
