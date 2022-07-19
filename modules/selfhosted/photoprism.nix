let
  servicename = "photoprism";
  shortname = "photos";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "photoprism/photoprism:220629-bullseye";

        environmentFiles = [ config.age.secrets.photos.path ];
        environment = {
          "PHOTOPRISM_SITE_URL" = "https://${shortname}.lab.home/";
          "PHOTOPRISM_ORIGINALS_LIMIT" = "5000";
          "PHOTOPRISM_HTTP_COMPRESSION" = "gzip";
          "PHOTOPRISM_DEBUG" = "false";
          "PHOTOPRISM_PUBLIC" = "false";
          "PHOTOPRISM_READONLY" = "false";
          "PHOTOPRISM_EXPERIMENTAL" = "false";
          "PHOTOPRISM_DISABLE_CHOWN" = "false";
          "PHOTOPRISM_DISABLE_WEBDAV" = "false";
          "PHOTOPRISM_DISABLE_SETTINGS" = "false";
          "PHOTOPRISM_DISABLE_TENSORFLOW" = "false";
          "PHOTOPRISM_DISABLE_FACES" = "false";
          "PHOTOPRISM_DISABLE_CLASSIFICATION" = "false";
          "PHOTOPRISM_DARKTABLE_PRESETS" = "false";
          "PHOTOPRISM_DETECT_NSFW" = "false";
          "PHOTOPRISM_UPLOAD_NSFW" = "true";
          "PHOTOPRISM_DATABASE_DRIVER" = "mysql";
          "PHOTOPRISM_DATABASE_SERVER" = "${servicename}-db:3306";
          "PHOTOPRISM_DATABASE_NAME" = "${servicename}";
          "PHOTOPRISM_DATABASE_USER" = "${servicename}";
          "PHOTOPRISM_SITE_TITLE" = "Zdjęcia";
          "PHOTOPRISM_SITE_CAPTION" = "Gronkiewicz";
          "PHOTOPRISM_SITE_DESCRIPTION" = "Zdjęcia zebrane przeze mnie";
          "PHOTOPRISM_SITE_AUTHOR" = "Patryk Gronkiewicz";
          "PHOTOPRISM_FFMPEG_BUFFERS" = "64";
          "PHOTOPRISM_FFMPEG_BITRATE" = "32";
          "PHOTOPRISM_FFMPEG_ENCODER" = "h264_v4l2m2m";
          "PHOTOPRISM_UID" = "1000";
          "PHOTOPRISM_GID" = "1000";
          "PHOTOPRISM_UMASK" = "0";
          "HOME" = "/${servicename}";
        };
        volumes = [
          "/media/data/${servicename}/originals:/${servicename}/original"
          "/media/data/${servicename}/storage:/${servicename}/storage"
        ];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.xyz`,`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
          "--network=nextcloud"
        ];
        dependsOn = [ "${servicename}-db" ];
        workdir = "/${servicename}";
      };
      "${servicename}-db" = {
        image = "mariadb:10.6";
        # cmd = [
        #   "mysqld --innodb-buffer-pool-size=128M --transaction-isolation=READ-COMMITTED --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci --max-connections=512 --innodb-rollback-on-timeout=OFF --innodb-lock-wait-timeout=120"
        # ];
        environment = {
          MYSQL_DATABASE = "${servicename}";
          MYSQL_USER = "${servicename}";
        };
        volumes = [ "/media/data/${servicename}/db:/var/lib/mysql" ];

        environmentFiles = [ config.age.secrets.photos-db.path ];
        extraOptions = [ "--network=nextcloud" ];
      };
    };
  };
}
