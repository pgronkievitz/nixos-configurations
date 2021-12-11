{ pkgs, ... }: {
  imports = [ ./cli ./shell ./localization.nix ];
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.paper-icon-theme;
      name = "Paper";
    };
    theme = {
      package = pkgs.paper-gtk-theme;
      name = "Paper";
    };
  };
  systemd.user.sessionVariables.EDITOR = "emacs";
  home.sessionVariables.EDITOR = "emacs";
  services.pasystray.enable = true;
  services.picom = {
    enable = true;
    fade = true;
    fadeDelta = 5;
  };
  xsession.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata_Classic";
  };
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
  };
}
