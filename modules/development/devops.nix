{ pkgs, ... }: {
  imports = [ ./kube.nix ];
  environment.systemPackages = [ pkgs.ansible pkgs.terraform ];
}
