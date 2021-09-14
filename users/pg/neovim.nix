{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    extraConfig = ''
      set nocompatible
      set number
      set relativenumber
      nnoremap j gj
      nnoremap k gk
    '';
  };
}
