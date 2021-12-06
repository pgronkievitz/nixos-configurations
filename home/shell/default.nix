{ lib, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    shellAliases = {
      g = "git";
      ping = "ping -c 3";
      space = "df -h -x tmpfs -x devtmpfs 2>& /dev/null";
      cp = "cp -i";
      mv = "mv -i";
      rm = "rm -I";
      ln = "ln -i";
      sysup =
        "sudo nixos-rebuild switch --flake '/home/pg/Projects/private/nixos-configurations#'";
    };
    dirHashes = {
      docs = "$HOME/Documents";
      proj = "$HOME/Projects";
      nts = "$HOME/Documents/notes";
      dl = "$HOME/Downloads";
    };
    enableSyntaxHighlighting = true;
    enableAutosuggestions = true;
    defaultKeymap = "viins";
    plugins = [
      {
        name = "p10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "p10k-config";
        src = lib.cleanSource ./p10k-config;
        file = "p10k.zsh-theme";
      }
    ];
    sessionVariables.EDITOR = "emacs";
  };
}
