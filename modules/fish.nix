{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    package = pkgs.fish;
  };

  users.users.venkatesh.shell = pkgs.fish;
}
