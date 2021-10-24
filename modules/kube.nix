{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ kubectl kubernetes-helm ];
  # services.k3s = {
  #   enable = true;
  #   role = "server";
  # };
}
