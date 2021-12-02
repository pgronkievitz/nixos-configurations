{ pkgs, ... }:
let
  my-python-packages = python-packages: [
    python-packages.grip
    python-packages.pyflakes
    python-packages.isort
    python-packages.pytest
    python-packages.flake8
    python-packages.pylint
    python-packages.mypy
    python-packages.nose
  ];
  python-with-my-packages = pkgs.python3.withPackages my-python-packages;
in {
  environment.systemPackages =
    [ python-with-my-packages pkgs.pipenv pkgs.black pkgs.pyright ];
}
