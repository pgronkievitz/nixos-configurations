{ pkgs, ... }: {
  imports = [ ./kube.nix ];
  environment.systemPackages = [ pkgs.ansible_2_9 pkgs.ansible ];
}
