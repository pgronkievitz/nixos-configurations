let
  servicename = "sonarr";
  shortname = "son";
  port = "9401";
  domains = [
    "www.${shortname}.gronkiewicz.xyz"
    "${servicename}.gronkiewicz.xyz"
    "www.${servicename}.gronkiewicz.xyz"
  ];
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "lscr.io/linuxserver/sonarr:3.0.6";
        ports = [ "${port}:8989" ];
        volumes = [
          "/media/data/${servicename}/config:/config"
          "/media/data/${servicename}/tv:/tv"
          "/media/data/${servicename}/downloads:/downloads"
        ];
        environment.TZ = "Europe/Warsaw";
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
