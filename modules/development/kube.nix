{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.kubectl pkgs.kubernetes-helm ];
}
