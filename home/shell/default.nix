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
      deploy-all =
        "nix run github:serokell/deploy-rs -- --targets '/home/pg/Projects/private/nixos-configurations#'";
      arch = "lxc exec dev -- su - pg";
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
    sessionVariables.EDITOR = "emacs";
  };
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      format = lib.concatStrings [
        "$username"
        "$shlvl"
        "$kubernetes"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_metrics"
        "$git_status"
        "$container"
        "$golang"
        "$helm"
        "$pulumi"
        "$python"
        "$rlang"
        "$terraform"
        "$vagrant"
        "$nix_shell"
        "$conda"
        "$env_var"
        "$line_break"
        "$directory"
        "$hostname"
        "$cmd_duration"
        "$jobs"
        "$battery"
        "$status"
        "$character"
      ];
      kubernetes.disabled = false;
      python.version_format = "\${major}.\${minor}";
      nix_shell.impure_msg = "!";
      directory = {
        truncation_symbol = "📂/";
        home_symbol = "🏠";
      };
      cmd_duration = {
        format = "$duration ($style)";
        show_notifications = true;
      };
      status = {
        pipestatus = true;
        disabled = false;
      };
    };
  };
}
