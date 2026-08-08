{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
    HandleLidSwitchDocked = "ignore";
    HandlePowerKey = "ignore";
    HandlePowerKeyLongPress = "poweroff";
  };

  services.fprintd.enable = true;
  services.power-profiles-daemon.enable = true;

  security.pam.services = {
    greetd.fprintAuth = false;
    hyprlock.fprintAuth = false;
    sudo.fprintAuth = true;
  };
}
