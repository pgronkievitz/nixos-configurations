{ config, pkgs, ... }: {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  imports = [
    ./emacs.nix
    ./alacrity.nix
    ./dunst.nix
    ./zathura.nix
    ./bat.nix
    ./syncthing.nix
    ./lorri.nix
    ./lsd.nix
    ./mpv.nix
    ./fzf.nix
    ./neovim.nix
    ./redshift.nix
    ./ssh.nix
    ./git.nix
    ./zsh.nix
    ./rofi.nix
    ./xserver.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "pg";
  home.homeDirectory = "/home/pg";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";
}
