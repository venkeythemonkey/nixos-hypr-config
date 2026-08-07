{ lib, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.adwaita-icon-theme
    pkgs.kdePackages.breeze
    pkgs.kdePackages.breeze-icons
    pkgs.qtengine
  ];

  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qtengine";
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };

  qt.enable = true;

  programs.dconf = {
    enable = true;

    profiles.user.databases = [
      {
        settings."org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          cursor-size = lib.gvariant.mkInt32 24;
          cursor-theme = "Adwaita";
          gtk-theme = "Adwaita-dark";
        };
      }
    ];
  };
}
