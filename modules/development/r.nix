{ pkgs, ... }:
let
  R-with-my-pkgs = pkgs.rWrapper.override {
    packages = [
      pkgs.rPackages.ggplot2
      pkgs.rPackages.knitr
      pkgs.rPackages.tidyverse
      pkgs.rPackages.forecast
      pkgs.rPackages.lintr
      pkgs.rPackages.languageserver
    ];
  };
in { environment.systemPackages = [ R-with-my-pkgs ]; }
