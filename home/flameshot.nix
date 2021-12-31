{ config, pkgs, ... }: {
  services.flameshot = {
    enable = true;
    settings.General = {
      showHelp = false;
      showDesktopNotification = false;
      disabledTrayIcon = true;
      showStartupLaunchMessage = false;
    };
  };
}
