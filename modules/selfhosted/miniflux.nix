let
  servicename = "miniflux";
  shortname = "rss";
in
{ pkgs, config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "miniflux/miniflux:2.0.41-distroless";
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
          "--label=flame.type=app"
          "--label=flame.name=${servicename}"
          "--label=flame.url=https://${shortname}.lab.home"
          "--label=flame.icon=rss"
          "--network=${servicename}"
        ];
        environmentFiles = [ config.age.secrets.miniflux.path ];
        dependsOn = [ "${servicename}-db" ];
      };
      "${servicename}-db" = {
        image = "postgres:14.2-alpine";
        volumes = [ "/media/data/${servicename}/db:/var/lib/postgresql/data" ];
        extraOptions = [ "--network=${servicename}" ];
        environmentFiles = [ config.age.secrets.minifluxdb.path ];
      };
    };
  };
}
