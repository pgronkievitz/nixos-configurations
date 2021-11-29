{ pkgs, ... }: {
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    enableNvidia = true;
  };
  virtualisation.oci-containers.backend = "podman";
  users.groups.services = { };
  users.users.podman = {
    isSystemUser = true;
    group = "podman";
  };
  environment.systemPackages = [ pkgs.docker-client ];
}
