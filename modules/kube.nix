{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ kubectl ];
  # services.k3s = {
  #   enable = true;
  #   role = "server";
  # };
}
