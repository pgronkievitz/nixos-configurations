{ config, lib, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    font = "FantasqueSansMono Nerd Font 16";
    theme = "paper-float";
  };
}
