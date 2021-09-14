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
      space = "df -h -x tmpfs 2>& /dev/null";
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
      src = lib.fetchGit {
        name = "p10k";
        url = "https://github.com/romkatv/powerlevel10k.git";
        ref = "refs/heads/master";
      };
    }];
  };
}
