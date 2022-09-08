let
  servicename = "friendica";
  shortname = "social";
in { pkgs, config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "friendica:2022.09-apache";
        environment = {
          FRIENDICA_URL = "${shortname}.gronkiewicz.dev";
          FIRENDICA_TZ = "UTC";
          FRIENDICA_LANG = "en_US";
          FIENDICA_SITENAME = "pgronkievitz's friendica";
          REDIS_HOST = "${servicename}-redis";
          MYSQL_HOST = "${servicename}-db";
        };
        environmentFiles = [ config.age.secrets.friendica.path ];
        dependsOn = [ "${servicename}-db" ];
        volumes = [ "/media/data/${servicename}/data/html:/var/www/html" ];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.dev`)"
          "--network=${servicename}"
        ];
      };
      "${servicename}-db" = {
        image = "mariadb:10.8.3-jammy";
        volumes = [ "/media/data/${servicename}/db:/var/lib/mysql" ];
        extraOptions = [ "--network=${servicename}" ];
        environmentFiles = [ config.age.secrets.friendicadb.path ];
      };
      "${servicename}-redis" = {
        image = "redis:6.2.6-alpine";
        volumes = [ "/media/data/${servicename}/redis:/usr/local/etc/redis" ];
        extraOptions = [ "--network=${servicename}" ];
      };
    };
  };
  services.cron.systemCronJobs = [
    "*/5 * * * * pg ${pkgs.docker}/bin/docker exec -u 33 friendica php bin/worker.php"
  ];
}
