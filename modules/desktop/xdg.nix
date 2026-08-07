{ lib, pkgs, ... }:

let
  imageMimeTypes = [
    "image/gif"
    "image/jpeg"
    "image/png"
    "image/webp"
  ];

  setImageMimeDefaults = pkgs.writeShellScript "set-image-mime-defaults" ''
    set -eu

    for mimeType in ${lib.escapeShellArgs imageMimeTypes}; do
      ${pkgs.xdg-utils}/bin/xdg-mime default org.kde.gwenview.desktop "$mimeType"
    done

    ${pkgs.kdePackages.kservice}/bin/kbuildsycoca6 --noincremental
  '';
in
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

  # Keep KDE's user-level application database aligned with the system defaults.
  systemd.user.services.xdg-image-mime-defaults = {
    description = "Set image MIME defaults for KDE applications";
    wantedBy = [ "default.target" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = setImageMimeDefaults;
    };
  };
}
