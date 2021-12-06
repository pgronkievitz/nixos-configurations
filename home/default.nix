{ pkgs, ... }: {
  imports = [ ./cli ./shell ];
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
  home.keyboard = {
    layout = "pl";
    options = [ "caps:swapescape" ];
  };
}
