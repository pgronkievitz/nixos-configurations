{ pkgs, ... }: {
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    enableNvidia = true;
    defaultNetwork.dnsname.enable = true;
  };
  virtualisation.oci-containers.backend = "podman";
  users.groups.services = { };
  environment.systemPackages = [ pkgs.docker-client ];
}
