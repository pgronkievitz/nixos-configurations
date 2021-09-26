{ config, pkgs, ... }:
let
  my-python-packages = python-packages:
    with python-packages; [
      grip
      pyflakes
      isort
      pytest
    ];
  python-with-my-packages = pkgs.python3.withPackages my-python-packages;
  my-dicts = dicts: with dicts; [ en pl en-computers en-science ];
  my-aspell = pkgs.aspellWithDicts my-dicts;
in {
  home.packages = [
    pkgs.nixos-option
    pkgs.libreoffice-fresh
    pkgs.xkcd-font
    pkgs.gammastep
    pkgs.texlive.combined.scheme-medium
    pkgs.networkmanagerapplet
    pkgs.htop
    pkgs.gimp
    pkgs.picom
    pkgs.fd
    pkgs.nerdfonts
    pkgs.tailscale
    pkgs.multimc
    pkgs.killall
    pkgs.arandr
    pkgs.xorg.xwininfo
    pkgs.ripgrep
    pkgs.xclip
    pkgs.xwallpaper
    pkgs.brillo
    pkgs.lxappearance
    pkgs.numlockx
    pkgs.blueman
    pkgs.tealdeer
    pkgs.direnv
    pkgs.pinentry-qt
    pkgs.nodePackages.yaml-language-server
    # pkgs.ocrmypdf
    pkgs.multilockscreen
    pkgs.yadm
    pkgs.pcmanfm
    pkgs.pandoc
    my-aspell
    pkgs.ispell
    pkgs.languagetool
    pkgs.libreoffice
    pkgs.hugo
    pkgs.thunderbird-bin-91
    pkgs.birdtray
    pkgs.teams
    pkgs.kotatogram-desktop
    pkgs.git
    pkgs.git-lfs
    pkgs.sqlite
    pkgs.julia_16-bin
    python-with-my-packages
    pkgs.go
    pkgs.gocode
    pkgs.gomodifytags
    pkgs.gotests
    pkgs.gore
    pkgs.gopls
    # pkgs.kube3d
    pkgs.R
    pkgs.graphviz
    pkgs.github-cli
    pkgs.virt-manager
    pkgs.gnumake
    pkgs.cmake
    pkgs.gnuplot
    pkgs.editorconfig-core-c
    pkgs.pyright
    pkgs.black
    pkgs.jq
    pkgs.jre
    pkgs.maim
    pkgs.nixfmt
    pkgs.megasync
    pkgs.zip
    pkgs.unzip
    pkgs.rclone
    pkgs.pavucontrol
    pkgs.pamixer
    pkgs.youtube-dl
    pkgs.alsa-utils
    pkgs.freetube
    pkgs.calibre
    pkgs.spotify
    pkgs.spicetify-cli
    pkgs.wget
    pkgs.curl
    pkgs.firefox
    pkgs.brave
    pkgs.spectacle
  ];
}
