let
  servicename = "archivebox";
  shortname = "archive";
in
{ config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "turian/archivebox:migrations-0021";
        environment = {
          ALLOWED_HOSTS = "*";
          MEDIA_MAX_SIZE = "1g";
        };
        volumes = [ "/media/data/${servicename}:/data" ];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
          "--label=flame.type=app"
          "--label=flame.name=${servicename}"
          "--label=flame.url=https://${shortname}.lab.home"
          "--label=flame.icon=archive"
        ];
      };
    };
  };
}
