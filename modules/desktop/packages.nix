{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    brightnessctl
    grim
    playerctl
    unstable.hyprland-qtutils
    unstable.hyprpolkitagent
    unstable.kitty
    xdg-user-dirs
  ];
}
