{ config, pkgs, username, ... }:

{
  # Required shared container configuration such as storage and registries.
  virtualisation.containers.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  environment.sessionVariables = {
    DBX_CONTAINER_MANAGER = "podman";
    DBX_CONTAINER_HOME_PREFIX =
      "${config.users.users.${username}.home}/Projects/distrobox";
    DBX_CONTAINER_ALWAYS_PULL = "1";
  };

  users.users.${username} = {
    extraGroups = [ "podman" ];
    subUidRanges = [{ startUid = 100000; count = 65536; }];
    subGidRanges = [{ startGid = 100000; count = 65536; }];
  };

  environment.systemPackages = with pkgs; [
    distrobox
  ];
}

