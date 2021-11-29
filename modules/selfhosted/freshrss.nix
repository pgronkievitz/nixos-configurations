let
  servicename = "freshrss";
  shortname = "rss";
  port = "9401";
in {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "lscr.io/linuxserver/freshrss:1.18.1";
        ports = [ "${port}:80" ];
        environment = { TZ = "Europe/Warsaw"; };
        volumes = [ "/media/data/${servicename}:/config" ];
      };
    };
  };
  services.nginx.virtualHosts = {
    "${shortname}.gronkiewicz.xyz" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "https://127.0.0.1:${port}";
        extraConfig = "proxy_ssl_server_name on;"
          + "proxy_pass_header Authorization;";
      };
      serverAliases = [
        "www.${shortname}.gronkiewicz.xyz"
        "${servicename}.gronkiewicz.xyz"
        "www.${servicename}.gronkiewicz.xyz"
      ];
    };
  };
}
