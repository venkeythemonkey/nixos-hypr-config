{ pkgs, ... }:

{
  systemd.user.services.xdg-user-dirs = {
    description = "Create XDG user directories";
    wantedBy = [ "default.target" ];
    before = [ "stow-dotfiles.service" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.xdg-user-dirs}/bin/xdg-user-dirs-update";
    };
  };
}
