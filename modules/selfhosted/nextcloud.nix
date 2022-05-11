let
  servicename = "nextcloud";
  shortname = "nc";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "nextcloud:24.0.0";
        volumes = [
          "/media/data/${servicename}/data:/var/www/html"
          "/media/data/${servicename}/php.ini:/usr/local/etc/php/conf.d/zzz-custom.ini"
        ];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.xyz`,`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
          "--label=traefik.http.middlewares.${servicename}-dav.redirectregex.permanent=true"
          "--label=traefik.http.middlewares.${servicename}-dav.redirectregex.regex=https://(.*)/.well-known/(card|cal)dav"
          "--label=traefik.http.middlewares.${servicename}-dav.redirectregex.replacement=https://\${1}/remote.php/dav/"
          "--label=traefik.http.middlewares.${servicename}-sts.headers.stsSeconds=31536000"
          "--label=traefik.http.middlewares.${servicename}.chain.middlewares=${servicename}-dav,${servicename}-sts"
          "--label=traefik.http.routers.${servicename}.middlewares=${servicename}"
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
  services.prometheus.exporters.nextcloud = {
    enable = true;
    passwordFile = config.age.secrets.ncmonitoring.path;
    url = "https://nc.lab.local";
  };
}
