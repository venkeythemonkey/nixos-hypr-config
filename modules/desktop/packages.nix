{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    brightnessctl
    flameshot
    grim
    kdePackages.dolphin
    playerctl
    unstable.hyprpolkitagent
    unstable.hyprshutdown
    unstable.kitty
    xdg-user-dirs
  ];
}
