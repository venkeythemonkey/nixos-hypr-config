{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    brightnessctl
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
