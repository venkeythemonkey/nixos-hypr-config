{ pkgs, ... }:

{
  programs.firefox.enable = true;

  # Work around missing Firefox UI text with the native Wayland backend.
  environment.sessionVariables.MOZ_ENABLE_WAYLAND = "0";

  environment.systemPackages = with pkgs; [
    brave
  ];
}
