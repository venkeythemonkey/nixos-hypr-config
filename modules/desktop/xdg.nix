{ pkgs, ... }:

{
  xdg.mime.defaultApplications = {
    "application/pdf" = "org.kde.okular.desktop";
    "image/gif" = "org.kde.gwenview.desktop";
    "image/jpeg" = "org.kde.gwenview.desktop";
    "image/png" = "org.kde.gwenview.desktop";
    "image/webp" = "org.kde.gwenview.desktop";
    "inode/directory" = "org.kde.dolphin.desktop";
    "text/html" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
  };

  systemd.user.services.xdg-user-dirs = {
    description = "Create XDG user directories";
    wantedBy = [ "default.target" ];
    before = [ "stow-dotfiles.service" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.xdg-user-dirs}/bin/xdg-user-dirs-update";
      ExecStartPost = "${pkgs.coreutils}/bin/mkdir -p %h/Pictures/Screenshots";
    };
  };
}
