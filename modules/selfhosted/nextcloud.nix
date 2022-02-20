let
  servicename = "nextcloud";
  shortname = "nc";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "nextcloud:23.0.2";
        volumes = [ "/media/data/${servicename}/data:/var/www/html" ];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.xyz`,`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
          "--label=traefik.http.middlewares.${servicename}-dav.redirectRegex.permanent=true"
          ''
            --label=traefik.http.middlewares.${servicename}-dav.redirectRegex.regex="https://${servicename}.lab.home/.well-known/(card|cal)dav"''
          ''
            --label=traefik.http.middlewares.${servicename}-dav.redirectRegex.replacement="https://${servicename}.lab.home/remote.php/dav/"''
          "--label=traefik.http.middlewares.${servicename}-sts.headers.stsSeconds=31536000"
          "--label=traefik.http.routers.${servicename}.middlewares=${servicename}"
          "--label=traefik.http.middlewares.${servicename}.chain.middlewares=${servicename}-dav,${servicename}-sts"
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
  # services.prometheus.exporters.nextcloud = {
  #   enable = true;
  #   passwordFile = "";
  #   user = "";
  #   url = "";
  # };
}
