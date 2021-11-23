{ pkgs, ... }: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraPackages = (epkgs: [ epkgs.vterm ]);
  };

  services.emacs = {
    enable = true;
    package = pkgs.emacs;
    client.enable = true;
  };

  systemd.user.services.emacs.Unit = {
    After = [ "graphical-session-pre.target" ];
    PartOf = [ "graphical-session.target" ];
  };
}
