{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nixos-option
    fd
    tailscale
    killall
    ripgrep
    tealdeer
    direnv
    nodePackages.yaml-language-server
    hugo
    git
    git-lfs
    sqlite
    julia_16-bin
    go
    gocode
    gomodifytags
    gotests
    gore
    gopls
    R
    graphviz
    github-cli
    virt-manager
    gnumake
    cmake
    gnuplot
    editorconfig-core-c
    pyright
    black
    jq
    jre
    nixfmt
    zip
    unzip
    rclone
    wget
    curl
  ];
}