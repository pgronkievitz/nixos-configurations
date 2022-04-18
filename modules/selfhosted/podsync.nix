let
  servicename = "podsync";
  shortname = "pod";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "mxpv/podsync:v2.4.2";
        volumes = [ "/media/data/${servicename}:/app/data" "/media/data/${servicename}/config.toml:/app/config.toml"];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.xyz`,`${shortname}.lab.home`)"
          "--label=traefik.http.services.${servicename}.loadbalancer.server.port=8080"
          "--label=traefik.http.routers.${servicename}.tls=true"
        ];
      };
    };
  };
}
