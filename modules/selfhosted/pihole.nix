let
  servicename = "pihole";
  shortname = "dns";
  port = 10001;
  domains = [ "${servicename}.gronkiewicz.xyz" ];
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "pihole/pihole:2021.12.1";
        ports = [
          "127.0.0.1:${builtins.toString port}:80"
          "100.111.43.19:${builtins.toString port}:80"
          # regular DNS
          "53:53/tcp"
          "53:53/udp"
        ];
        volumes = [
          "/media/data/${servicename}/dnsmasq:/etc/pihole"
          "/media/data/${servicename}/pihole:/etc/dnsmasq.d"
        ];
        environment = { TZ = "Europe/Warsaw"; };
      };
    };
  };
  services.nginx.virtualHosts = {
    "${shortname}.gronkiewicz.xyz" = {
      useACMEHost = "${shortname}.gronkiewicz.xyz";
      forceSSL = true;
      locations."/".proxyPass = "http://127.0.0.1:${builtins.toString port}";
      serverAliases = domains;
    };
  };
  security.acme.certs."${shortname}.gronkiewicz.xyz" = {
    extraDomainNames = domains;
    dnsProvider = "cloudflare";
    credentialsFile = config.age.secrets.cloudflare.path;
  };
}
