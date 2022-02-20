let
  servicename = "nextcloud";
  shortname = "nc";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "nextcloud:23.0.1";
        volumes = [ "/media/data/${servicename}/data:/var/www/html" ];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.xyz`,`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
          "--label=traefik.http.middlewares.${servicename}-dav.redirectRegex.permanent=true"
          ''
            --label=traefik.http.middlewares.${servicename}-dav.redirectRegex.regex="https://(.*)/.well-known/(card|cal)dav"''
          ''
            --label=traefik.http.middlewares.${servicename}-dav.redirectRegex.replacement="https://$$1/remote.php/dav/"''
          "--label=traefik.http.middlewares.${servicename}-sts.headers.stsSeconds=31536000"
          "--label=traefik.http.routers.${servicename}.middlewares=${servicename}"
          "--label=traefik.http.middlewares.${servicename}.chain.middlewares=${servicename}-sts,${servicename}-dav"
          "--network=${servicename}"
        ];
        dependsOn = [ "${servicename}-db" "${servicename}-redis" ];
      };
      "${servicename}-db" = {
        image = "postgres:14.2-alpine";
        volumes = [ "/media/data/${servicename}/db:/var/lib/postgresql/data" ];
        extraOptions = [ "--network=${servicename}" ];
        environmentFiles = [ config.age.secrets.ncdb.path ];
      };
      "${servicename}-redis" = {
        image = "redis:6.2.6-alpine";
        volumes = [ "/media/data/${servicename}/redis:/usr/local/etc/redis" ];
        extraOptions = [ "--network=${servicename}" ];
      };
    };
  };
}
