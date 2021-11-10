{ config, pkgs, ... }: {
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
  services.lorri.enable = true;
}
