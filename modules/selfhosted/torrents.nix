let
  servicename = "transmission";
  shortname = "torrent";
  port = "9301";
  domains = [
    "www.${shortname}.gronkiewicz.xyz"
    "${servicename}.gronkiewicz.xyz"
    "www.${servicename}.gronkiewicz.xyz"
  ];
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "lscr.io/linuxserver/transmission:version-3.00-r2";
        ports = [ "${port}:9091" "51413:51413" "51413:51413/udp" ];
        environment = { TZ = "Europe/Warsaw"; };
        volumes = [
          "/media/data/${servicename}/config:/config"
          "/media/data/${servicename}/downloads:/downloads"
          "/media/data/${servicename}/watch:/watch"
        ];
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
