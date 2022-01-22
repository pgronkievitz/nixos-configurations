let
  servicename = "calibre";
  shortname = "cal";
  port = "9901";
  domains = [
    "www.${shortname}.gronkiewicz.xyz"
    "${servicename}.gronkiewicz.xyz"
    "www.${servicename}.gronkiewicz.xyz"
  ];
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "lscr.io/linuxserver/calibre-web:0.6.15";
        ports = [ "${port}:8083" ];
        volumes = [
          "/media/data/${servicename}/config:/config"
          "/media/data/${servicename}/books:/books"
        ];
        environment = {
          TZ = "Europe/Warsaw";
          DOCKER_MODS = "linuxserver/calibre-web:calibre";
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
      extraConfig = "client_max_body_size 100M;";
    };
  };
  security.acme.certs."${shortname}.gronkiewicz.xyz" = {
    extraDomainNames = domains;
    dnsProvider = "cloudflare";
    credentialsFile = config.age.secrets.cloudflare.path;
  };
}
