{ pkgs, ... }:

let
  hyprlandLuaCheck = pkgs.runCommand "hyprland-lua-check" {
    nativeBuildInputs = [ pkgs.lua ];
  } ''
    while IFS= read -r -d "" lua_file; do
      luac -p "$lua_file"
    done < <(${pkgs.findutils}/bin/find ${../../dotfiles/hypr/.config/hypr} -type f -name "*.lua" -print0)

    touch "$out"
  '';
in
{
  # Make `nh os build` reject syntax errors in the Stow-managed Lua config.
  system.extraDependencies = [ hyprlandLuaCheck ];
}
