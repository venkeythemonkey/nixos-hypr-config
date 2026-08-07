{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."venkatesh" = {
    isNormalUser = true;
    description = "Venkatesh S";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
}
