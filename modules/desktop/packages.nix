{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    brightnessctl
    grim
    hyprpicker
    libnotify
    playerctl
    slurp
    (tesseract.override { enableLanguages = [ "eng" ]; })
    unstable.hyprland-qtutils
    unstable.kitty
    wl-clipboard
    xdg-user-dirs
  ];
}
