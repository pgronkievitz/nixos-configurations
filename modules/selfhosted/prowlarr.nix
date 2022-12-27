let
  servicename = "prowlarr";
  shortname = "pro";
in
{ config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "lscr.io/linuxserver/prowlarr:1.0.0-nightly";
        volumes = [ "/media/data/${servicename}:/config" ];
        environment.TZ = "Europe/Warsaw";
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
          "--network=torrenting"
        ];
      };
    };
  };
}
