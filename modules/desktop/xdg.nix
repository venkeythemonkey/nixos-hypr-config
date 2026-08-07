{ lib, pkgs, ... }:

let
  gnomeMimeDefaults = {
    "application/pdf" = "org.gnome.Papers.desktop";
    "image/gif" = "org.gnome.Loupe.desktop";
    "image/jpeg" = "org.gnome.Loupe.desktop";
    "image/png" = "org.gnome.Loupe.desktop";
    "image/webp" = "org.gnome.Loupe.desktop";
    "inode/directory" = "org.gnome.Nautilus.desktop";
  };

  browserMimeDefaults = {
    "text/html" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
  };

  setUserMimeDefaults = pkgs.writeShellScript "set-user-mime-defaults" ''
    set -eu

    ${lib.concatStringsSep "\n" (
      lib.mapAttrsToList (
        mimeType: desktopFile:
        "${pkgs.xdg-utils}/bin/xdg-mime default ${lib.escapeShellArg desktopFile} ${lib.escapeShellArg mimeType}"
      ) gnomeMimeDefaults
    )}
  '';
in
{
  xdg.mime.defaultApplications = gnomeMimeDefaults // browserMimeDefaults;

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

  # Keep the user's application database aligned without replacing unrelated entries.
  systemd.user.services.xdg-mime-defaults = {
    description = "Set user MIME defaults";
    wantedBy = [ "default.target" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = setUserMimeDefaults;
    };
  };
}
