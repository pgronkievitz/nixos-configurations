{ pkgs, ... }: {
  imports = [ ./cli ./shell ./localization.nix ];
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.flat-remix-icon-theme;
      name = "Flat-Remix-Blue-Light";
    };
    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Blue-Light";
    };
  };
  systemd.user.sessionVariables.EDITOR = "emacs";
  home.sessionVariables.EDITOR = "emacs";
  services.pasystray.enable = true;
  services.picom = {
    enable = true;
    fade = true;
    fadeDelta = 5;
    package = pkgs.picom-dccsillag;
  };
  xsession.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
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
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
