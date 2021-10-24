{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ kube3d k3s minikube kubectl ];
  # services.k3s = {
  #   enable = true;
  #   role = "server";
  # };
}
