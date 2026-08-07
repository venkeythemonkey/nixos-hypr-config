{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    brightnessctl
    grim
    kdePackages.dolphin
    kdePackages.gwenview
    kdePackages.okular
    playerctl
    unstable.hyprland-qtutils
    unstable.hyprpolkitagent
    unstable.hyprshutdown
    unstable.kitty
    xdg-user-dirs
  ];
}
