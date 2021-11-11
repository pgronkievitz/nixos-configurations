{ pkgs, ... }:
let
  R-with-my-pkgs = pkgs.rWrapper.override {
    packages = [
      pkgs.rPackages.ggplot2
      pkgs.rPackages.knitr
      pkgs.rPackages.tidyverse
      pkgs.rPackages.forecast
    ];
  };
in { environment.systemPackages = [ R-with-my-pkgs ]; }
