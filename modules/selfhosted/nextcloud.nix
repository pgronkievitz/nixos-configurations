let
  servicename = "nextcloud";
  shortname = "nc";
in
{ pkgs, config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "nextcloud:25.0.2";
        volumes = [
          "/media/data/${servicename}/data:/var/www/html"
          "/media/data/${servicename}/php.ini:/usr/local/etc/php/conf.d/zzz-custom.ini"
        ];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
          "--label=traefik.http.middlewares.${servicename}-dav.redirectregex.permanent=true"
          "--label=traefik.http.middlewares.${servicename}-dav.redirectregex.regex=https://(.*)/.well-known/(card|cal)dav"
          "--label=traefik.http.middlewares.${servicename}-dav.redirectregex.replacement=https://\${1}/remote.php/dav/"
          "--label=traefik.http.middlewares.${servicename}-sts.headers.stsSeconds=31536000"
          "--label=traefik.http.middlewares.${servicename}.chain.middlewares=${servicename}-dav,${servicename}-sts"
          "--label=traefik.http.routers.${servicename}.middlewares=${servicename}"
          "--label=flame.type=app"
          "--label=flame.name=${servicename}"
          "--label=flame.url=https://${shortname}.lab.home"
          "--label=flame.icon=cloud"
          "--network=${servicename}"
        ];
        dependsOn = [ "${servicename}-db" "${servicename}-redis" ];
      };
      "${servicename}-db" = {
        image = "postgres:14.5-alpine";
        volumes = [ "/media/data/${servicename}/db:/var/lib/postgresql/data" ];
        extraOptions = [ "--network=${servicename}" ];
        environmentFiles = [ config.age.secrets.ncdb.path ];
      };
      "${servicename}-redis" = {
        image = "redis:7.0.4-alpine";
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
  services.cron.systemCronJobs = [
    "*/5 * * * * pg ${pkgs.docker}/bin/docker exec -u 33 nextcloud php cron.php"
  ];
}
