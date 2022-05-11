let
  servicename = "gitea";
  shortname = "git";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "gitea/gitea:1.16.7";
        volumes = [ "/media/data/${servicename}:/data" ];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.xyz`,`${shortname}.lab.home`)"
          "--label=traefik.http.services.${servicename}.loadbalancer.server.port=3000"
          "--label=traefik.http.routers.${servicename}.tls=true"
        ];
        ports = [ "22:22" ];
      };
    };
  };
}
