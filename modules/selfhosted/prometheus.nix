let
  servicename = "prometheus";
  shortname = "prometheus";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "prom/prometheus:v2.35.0";
        environment = { TZ = "Europe/Warsaw"; };
        volumes = [
          "/media/data/${servicename}/config.yml:/etc/prometheus/prometheus.yml:ro"
          "/media/data/${servicename}/data:/prometheus"
        ];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.xyz`,`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
        ];
      };
    };
  };
}
