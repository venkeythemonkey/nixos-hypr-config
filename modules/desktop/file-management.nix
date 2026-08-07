{ ... }:

{
  # Let desktop applications discover and mount removable storage through Polkit.
  services.udisks2.enable = true;
}
