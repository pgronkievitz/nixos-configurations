{ config, lib, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    font = "FantasqueMono Nerd Font 16";
    theme = "paper-float";
  };
}
