let
  servicename = "uptimekuma";
  shortname = "uptime";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "louislam/uptime-kuma:1.15.1-alpine";
        environment = { TZ = "Europe/Warsaw"; };
        volumes = [ "/media/data/${servicename}/data:/app/data" ];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.xyz`,`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
        ];
      };
    };
  };
}
