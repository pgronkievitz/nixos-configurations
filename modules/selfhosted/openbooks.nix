let
  servicename = "openbooks";
  shortname = "books";
in
{ config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "evanbuss/openbooks:4.4.1";
        environment = { TZ = "Europe/Warsaw"; };
        volumes = [ "/media/data/${servicename}:/books" ];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
          "--label=flame.type=app"
          "--label=flame.name=${servicename}"
          "--label=flame.url=https://${shortname}.lab.home"
          "--label=flame.icon=book"
        ];
        cmd = [ "--persist" ];
      };
    };
  };
}
