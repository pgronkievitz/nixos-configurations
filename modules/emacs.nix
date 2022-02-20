{ pkgs, ... }: {
  services.emacs = {
    enable = true;
    package = pkgs.emacsGcc;
    extraPackages = (epkgs: [ epkgs.vterm ]);
  };
}
