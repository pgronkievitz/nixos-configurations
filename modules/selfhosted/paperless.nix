let
  servicename = "paperless";
  shortname = "docs";
  port = "12001";
  domains = [
    "www.${shortname}.gronkiewicz.xyz"
    "${servicename}.gronkiewicz.xyz"
    "www.${servicename}.gronkiewicz.xyz"
  ];
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "lscr.io/linuxserver/paperless-ng:1.5.0";
        ports = [ "${port}:8000" ];
        volumes = [
          "/media/data/${servicename}/config:/config"
          "/media/data/${servicename}/data:/data"
        ];
        environment = {
          TZ = "Europe/Warsaw";
          PUID = "1000";
          PGID = "1000";
        };
      };
    };
  };
  services.nginx.virtualHosts = {
    "${shortname}.gronkiewicz.xyz" = {
      useACMEHost = "${shortname}.gronkiewicz.xyz";
      forceSSL = true;
      locations."/".proxyPass = "http://127.0.0.1:${port}";
      serverAliases = domains;
    };
  };
  security.acme.certs."${shortname}.gronkiewicz.xyz" = {
    extraDomainNames = domains;
    dnsProvider = "cloudflare";
    credentialsFile = config.age.secrets.cloudflare.path;
  };
}
