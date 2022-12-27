let
  servicename = "flame";
  shortname = "dash";
in
{ config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "pawelmalak/flame:2.3.0";
        environment = {
          PASSWORD = "admin"; # it's not critical anyways
        };
        volumes = [ "/media/data/${servicename}:/app/data" ];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
        ];
      };
    };
  };
}
