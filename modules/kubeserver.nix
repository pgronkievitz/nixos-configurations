{ pkgs, ... }: {
  services.k3s = {
    enable = false;
    role = "server";
  };
}
