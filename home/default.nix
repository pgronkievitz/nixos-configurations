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
}
