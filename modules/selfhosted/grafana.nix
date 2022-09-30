let
  servicename = "grafana";
  shortname = "grafana";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "grafana/grafana-oss:9.1.6";
        environment = { TZ = "Europe/Warsaw"; };
        volumes = [ "/media/data/${servicename}:/var/lib/grafana" ];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.xyz`,`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
        ];
      };
    };
  };
}
