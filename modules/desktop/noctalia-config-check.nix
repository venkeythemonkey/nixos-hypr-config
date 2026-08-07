{ pkgs, ... }:

let
  noctaliaConfigCheck = pkgs.runCommand "noctalia-config-check" {
    nativeBuildInputs = [ pkgs.unstable.noctalia ];
  } ''
    export HOME="$TMPDIR"
    export XDG_CACHE_HOME="$TMPDIR/cache"
    export XDG_CONFIG_HOME="$TMPDIR/config"
    export XDG_STATE_HOME="$TMPDIR/state"

    noctalia config validate ${../../dotfiles/noctalia/.config/noctalia}
    touch "$out"
  '';
in
{
  # Make `nh os build` reject invalid settings in the Stow-managed Noctalia config.
  system.extraDependencies = [ noctaliaConfigCheck ];
}
