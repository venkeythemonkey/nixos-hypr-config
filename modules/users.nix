{ pkgs, username, ... }:

{
  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.${username} = {
    isNormalUser = true;
    description = "Venkatesh S";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };

  environment.localBinInPath = true;
}
