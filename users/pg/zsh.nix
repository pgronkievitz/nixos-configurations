{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    shellAliases = {
      apollo = "ssh apollo";
      mikrus = "ssh mikrus";
      g = "git";
      ping = "ping -c 3";
      space = "df -h -x tmpfs -x devtmpfs 2>& /dev/null";
      cp = "cp -i";
      mv = "mv -i";
      rm = "rm -I";
      ln = "ln -i";
    };
    dirHashes = {
      docs = "$HOME/Documents";
      proj = "$HOME/Projects";
      nts = "$HOME/Documents/notes";
      dl = "$HOME/Downloads";
    };
    enableAutosuggestions = true;
    defaultKeymap = "viins";
    plugins = [{
      name = "p10k";
      src = pkgs.zsh-powerlevel10k;
    }];
    initExtra =
      "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme && source ~/.config/zsh//.p10k.zsh";
  };
}
