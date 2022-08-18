let
  servicename = "znc";
  shortname = "znc";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "znc:1.8.2";
        volumes = [ "/media/data/${servicename}:/znc-data" ];
        ports = [
          "5000:5000"
        ];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.xyz`,`${shortname}.lab.home`)"
          "--label=traefik.http.services.${servicename}.loadbalancer.server.port=5000"
          "--label=traefik.http.routers.${servicename}.tls=true"
        ];
      };
    };
  };
}
