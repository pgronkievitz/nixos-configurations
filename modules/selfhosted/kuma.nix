let
  servicename = "uptime-kuma";
  shortname = "uptime";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "prom/uptime-kuma:v1.11.4";
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
