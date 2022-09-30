{ pkgs, ... }: {
  xsession = {
    enable = true;
    numlock.enable = true;
    windowManager.awesome = {
      enable = true;
      luaModules = [ pkgs.luaPackages.vicious ];
    };
  };
  home.packages = [
    pkgs.autorandr
    pkgs.arandr
    pkgs.xorg.xwininfo
    pkgs.xclip
    pkgs.xwallpaper
    pkgs.brillo
    pkgs.light
    pkgs.acpi
    pkgs.pinentry-qt
    pkgs.betterlockscreen
    pkgs.maim
    pkgs.numlockx
  ];
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.flat-remix-icon-theme;
      name = "Flat-Remix-Blue-Light";
    };
    theme = {
      package = pkgs.plano-theme;
      name = "Plano";
    };
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };
  };
  services.pasystray.enable = true;
  services.picom = {
    enable = true;
    fade = true;
    fadeDelta = 5;
    package = pkgs.picom-dccsillag;
  };
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
  };
  services.betterlockscreen = {
    enable = true;
    arguments = [ "--dim" "20" "--blur" "0.3" "--wall" ];
  };
}
