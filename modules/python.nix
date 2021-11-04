{ config, pkgs, ... }:
let
  my-python-packages = python-packages:
    with python-packages; [
      grip
      pyflakes
      isort
      pytest
      flake8
      pylint
      mypy
    ];
  python-with-my-packages = pkgs.python3.withPackages my-python-packages;
in { environment.systemPackages = with pkgs; [ python-with-my-packages ]; }
