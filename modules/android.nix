{ pkgs, ... }: {
  programs.adb.enable = true;
  users.users.pg.extraGroups = [ "adbusers" ];
  services.udev.packages = [ pkgs.android-udev-rules ];
  services.gvfs.enable = true;
  environment.systemPackages = [ pkgs.jmtpfs ];
}
