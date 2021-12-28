{ pkgs, ... }: {
  virtualisation.podman = {
    enable = true;
    enableNvidia = true;
    defaultNetwork.dnsname.enable = true;
  };
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
  users.groups.services = { };
  environment.systemPackages = [ pkgs.docker-client ];
}
