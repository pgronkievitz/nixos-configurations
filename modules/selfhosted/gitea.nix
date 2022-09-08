let
  servicename = "gitea";
  shortname = "git";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "gitea/gitea:1.17.2";
        volumes = [ "/media/data/${servicename}:/data" ];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.dev`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
          "--label=traefik.http.routers.${servicename}.tls.certresolver=letsencrypt"

          "--label=traefik.http.services.${servicename}.loadbalancer.server.port=3000"
          "--network=${servicename}"
        ];
        ports = [ "22:22" ];
      };
      "${servicename}-db" = {
        image = "postgres:14.5-alpine";
        volumes = [ "/media/data/${servicename}/db:/var/lib/postgresql/data" ];
        extraOptions = [ "--network=${servicename}" ];
        environmentFiles = [ config.age.secrets.giteadb.path ];
      };
    };
  };
}
