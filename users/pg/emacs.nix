{ pkgs, ... }: {
  programs.emacs = {
    enable = true;
    extraPackages = (epkgs: [ epkgs.vterm ]);
    package = pkgs.emacsGcc;
  };

  services.emacs = {
    enable = true;
    package = pkgs.emacsGcc;
    client.enable = true;
  };

  systemd.user.services.emacs.Unit = {
    After = [ "graphical-session-pre.target" ];
    PartOf = [ "graphical-session.target" ];
  };
}
