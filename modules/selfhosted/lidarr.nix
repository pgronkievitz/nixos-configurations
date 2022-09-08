let
  servicename = "lidarr";
  shortname = "lid";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "youegraillot/lidarr-on-steroids:1.2.2";
        volumes = [
          "/media/data/${servicename}/config:/config"
          "/media/data/${servicename}/config_deemix:/config_deemix"
          "/media/data/${servicename}/music:/music"
          "/media/data/${servicename}/downloads:/downloads"
        ];
        environment.TZ = "Europe/Warsaw";
        user = "1000:1000";
        extraOptions = [
          "--label=traefik.http.routers.${servicename}-${shortname}.rule=Host(`${shortname}.lab.home`)"
          "--label=traefik.http.services.${servicename}-${shortname}.loadbalancer.server.port=8686"
          "--label=traefik.http.routers.${servicename}-${shortname}.tls=true"
          "--label=traefik.http.routers.${servicename}-${shortname}.service=${servicename}-${shortname}"
          "--label=traefik.http.routers.${servicename}-deemix.rule=Host(`deemix.lab.home`)"
          "--label=traefik.http.routers.${servicename}-deemix.tls=true"
          "--label=traefik.http.services.${servicename}-deemix.loadbalancer.server.port=6595"
          "--label=traefik.http.routers.${servicename}-deemix.service=${servicename}-deemix"
          "--network=torrenting"
        ];
      };
    };
  };
}
