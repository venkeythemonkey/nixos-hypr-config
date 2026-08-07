{
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/" ];
  };

  /* Disabled for now; keep this configuration ready for later use.
  services.snapper = {
    persistentTimer = true;

    configs.home = {
      SUBVOLUME = "/home";
      ALLOW_USERS = [ "venkatesh" ];
      SYNC_ACL = true;

      TIMELINE_CREATE = true;
      TIMELINE_CLEANUP = true;
      TIMELINE_LIMIT_HOURLY = 6;
      TIMELINE_LIMIT_DAILY = 7;
      TIMELINE_LIMIT_WEEKLY = 4;
      TIMELINE_LIMIT_MONTHLY = 3;
      TIMELINE_LIMIT_YEARLY = 0;
    };
  };

  # Snapper requires its snapshot directory to be a nested Btrfs subvolume.
  systemd.tmpfiles.settings."10-snapper-home"."/home/.snapshots".v = {
    user = "root";
    group = "root";
    mode = "0750";
  };
  */

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
    memoryMax = 4 * 1024 * 1024 * 1024;
    priority = 100;
  };
}
