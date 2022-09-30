{ pkgs, ... }: {
  imports = [ ./cli ./shell ./localization.nix ];
  systemd.user.sessionVariables.EDITOR = "emacs";
  home.sessionVariables.EDITOR = "emacs";
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
  home.stateVersion = "22.11";
}
