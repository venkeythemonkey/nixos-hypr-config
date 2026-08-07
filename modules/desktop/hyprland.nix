{ pkgs, ... }:

{
  # Avoid the large speech synthesis closure unless accessibility requires it.
  services.speechd.enable = false;

  programs.hyprland = {
    enable = true;
    package = pkgs.unstable.hyprland;
    portalPackage = pkgs.unstable.xdg-desktop-portal-hyprland;
  };

  programs.hyprlock = {
    enable = true;
    package = pkgs.unstable.hyprlock;
  };

  services.hypridle = {
    enable = true;
    package = pkgs.unstable.hypridle;
  };

  # Install the upstream user unit; Hyprland starts it with the session.
  systemd.packages = [ pkgs.unstable.hyprpolkitagent ];
}
