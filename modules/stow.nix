{ pkgs, ... }:

let
  stowDotfiles = pkgs.writeShellApplication {
    name = "stow-dotfiles";
    runtimeInputs = with pkgs; [
      coreutils
      findutils
      stow
    ];
    text = ''
      stow_directory="$1"
      stow_target="$2"

      mapfile -d "" -t stow_packages < <(
        find "$stow_directory" -mindepth 1 -maxdepth 1 -type d -printf "%f\0" |
          sort -z
      )

      if (( ''${#stow_packages[@]} == 0 )); then
        exit 0
      fi

      stow_options=(
        --restow
        --dir="$stow_directory"
        --target="$stow_target"
      )

      stow --simulate "''${stow_options[@]}" "''${stow_packages[@]}"
      stow "''${stow_options[@]}" "''${stow_packages[@]}"
    '';
  };
in
{
  systemd.user.services.stow-dotfiles = {
    description = "Stow user dotfiles";
    wantedBy = [ "default.target" ];
    requires = [ "xdg-user-dirs.service" ];
    after = [ "xdg-user-dirs.service" ];
    restartTriggers = [ ../dotfiles ];

    unitConfig.ConditionPathExists = "%h/nixos-hypr-config/dotfiles";

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${stowDotfiles}/bin/stow-dotfiles %h/nixos-hypr-config/dotfiles %h";
    };
  };
}
