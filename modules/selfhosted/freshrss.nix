let
  servicename = "freshrss";
  shortname = "rss";
  port = 9401;
in {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "lscr.io/linuxserver/freshrss:1.18.1";
        ports = [ "${port}:80" ];
        environment = { TZ = "Europe/Warsaw"; };
        volumes = [ "/media/data/${servicename}:/config" ];
        user = "${servicename}:services";
      };
    };
  };
  services.caddy.virtualHosts = {
    "${shortname}.gronkiewicz.xyz" = {
      serverAliases = [
        "www.${shortname}.gronkiewicz.xyz"
        "${servicename}.gronkiewicz.xyz"
        "www.${servicename}.gronkiewicz.xyz"
      ];
      extraConfig = ''
        reverse_proxy ${port}
        metrics /metrics
      '';
    };
  };
  users.extraUsers."${servicename}" = {
    extraGroups = [ "services" ];
    isSystemUser = true;
  };
}
