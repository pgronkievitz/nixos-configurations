{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ kubectl kubernetes-helm kompose ];
  # services.k3s = {
  #   enable = true;
  #   role = "server";
  # };
}
