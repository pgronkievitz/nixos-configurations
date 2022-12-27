let
  servicename = "gitea";
  shortname = "git";
in
{ config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "codeberg.org/forgejo/forgejo:1.18.0-rc1-1";
        volumes = [ "/media/data/${servicename}:/data" ];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.dev`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
          "--label=traefik.http.routers.${servicename}.tls.certresolver=letsencrypt"

          "--label=traefik.http.services.${servicename}.loadbalancer.server.port=3000"
          "--label=flame.type=app"
          "--label=flame.name=${servicename}"
          "--label=flame.url=https://${shortname}.lab.home"
          "--label=flame.icon=git"
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
