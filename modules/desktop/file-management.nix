{ pkgs, ... }:

{
  # Let desktop applications discover and mount local and remote storage.
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    file-roller
    gnome-calculator
    gnome-disk-utility
    loupe
    nautilus
    papers
  ];
}
