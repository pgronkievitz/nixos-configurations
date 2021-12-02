{ config, lib, pkgs, ... }:
{
  virtualisation.oci-containers = {
    containers = {
      gitea = {
        image = "docker.io/gitea/gitea:1.15.6-rootless";
        ports = [ "8081:3000" ];
        user = "pg";
        # login = {
        #   username = "pgronkievitz";
        #   registry = "https://docker.io";
        #   passwordFile = "/home/pg/.local/dockerhub-password.txt";
        # };
      };
    };
  };
}
