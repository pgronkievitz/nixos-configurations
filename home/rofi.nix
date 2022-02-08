{ config, lib, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    font = "VictorMono Nerd Font 16";
    theme = "paper-float";
  };
}
