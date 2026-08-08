{ ... }:

{
  programs.fish.enable = true;

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
