{ ... }:

{
  # Provide Secret Service storage for Noctalia's encrypted clipboard and
  # calendar data. The NixOS module also integrates the keyring with greetd.
  services.gnome.gnome-keyring.enable = true;
}
