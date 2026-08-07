{ pkgs, ... }:

{
  # Let desktop applications discover and mount removable storage through Polkit.
  services.udisks2.enable = true;

  environment.systemPackages = with pkgs.kdePackages; [
    ark
    dolphin
    ffmpegthumbs
    gwenview
    kdegraphics-thumbnailers
    okular
  ];
}
