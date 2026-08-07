{ pkgs, ... }:

{
  programs.firefox.enable = true;

  # Use Firefox's native Wayland backend.
  environment.sessionVariables.MOZ_ENABLE_WAYLAND = "1";

  environment.systemPackages = with pkgs; [
    brave
  ];
}
