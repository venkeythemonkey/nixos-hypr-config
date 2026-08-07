{ pkgs, ... }:

let
  package = pkgs.unstable.noctalia-greeter;
  settings = (pkgs.formats.toml { }).generate "greeter.toml" {
    session.default = "Hyprland";
    user.default = "venkatesh";
    output.scale = 1.0;
  };
in
{
  environment.systemPackages = [ package ];

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${package}/bin/noctalia-greeter-session --";
      user = "greeter";
    };
  };

  services.accounts-daemon.enable = true;

  systemd.tmpfiles.settings."10-noctalia-greeter" = {
    "/var/lib/noctalia-greeter".d = {
      user = "greeter";
      group = "greeter";
      mode = "0750";
    };

    "/var/lib/noctalia-greeter/greeter.toml"."L+" = {
      argument = "${settings}";
      user = "greeter";
      group = "greeter";
    };
  };
}
