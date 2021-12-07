{ pkgs, ... }: {
  imports = [ ./cli ./shell ./localization.nix ];
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.maia-icon-theme;
      name = "Violet-Maia";
    };
    theme = {
      package = pkgs.orchis-theme;
      name = "Orchis-light";
    };
  };
  systemd.user.sessionVariables.EDITOR = "emacs";
  home.sessionVariables.EDITOR = "emacs";
  services.pasystray.enable = true;
  services.picom.enable = true;
  services.playerctld.enable = true;
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
  };
}
