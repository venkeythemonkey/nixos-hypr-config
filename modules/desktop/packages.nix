{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    brightnessctl
    flameshot
    grim
    kdePackages.dolphin
    kdePackages.gwenview
    kdePackages.okular
    playerctl
    unstable.hyprpolkitagent
    unstable.hyprshutdown
    unstable.kitty
    xdg-user-dirs
  ];
}
