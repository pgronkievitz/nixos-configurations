{ pkgs, ... }: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacsNativeComp;
    extraPackages = (epkgs: [ epkgs.vterm epkgs.melpaPackages.pdf-tools ]);
  };

  services.emacs = {
    enable = true;
    package = pkgs.emacsNativeComp;
    client.enable = true;
  };

  systemd.user.services.emacs.Unit = {
    After = [ "graphical-session-pre.target" ];
    PartOf = [ "graphical-session.target" ];
  };
  home.packages = [ pkgs.openjdk ];
}
