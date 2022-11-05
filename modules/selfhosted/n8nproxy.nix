{ config, lib, pkgs, ... }:

{
  services.traefik.dynamicConfigOptions = {
      http = {
        routers = {
          n8n = {
            rule = "Host(`n8n.gronkiewicz.dev`)";
            service = "n8n";
            tls.certresolver = "letsencrypt";
          };
        };
        services = {
          n8n = {
            loadBalancer.servers = [{ url = "https://n8n.lab.home"; }];
          };
        };
      };
    };
}
