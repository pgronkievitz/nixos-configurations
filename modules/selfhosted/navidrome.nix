let
  servicename = "navidrome";
  shortname = "music";
in
{ config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "deluan/navidrome:0.48.0";
        environment = {
          ND_SCANSCHEDULE = "1h";
          ND_LOGLEVEL = "INFO";
          ND_SESSIONTIMEOUT = "48h";
          ND_BASEURL = "";
        };
        volumes = [
          "/media/data/lidarr/music:/music:ro"
          "/media/data/${servicename}/data:/data"
        ];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
          "--label=flame.type=app"
          "--label=flame.name=${servicename}"
          "--label=flame.url=https://${shortname}.lab.home"
          "--label=flame.icon=headphones"
        ];
      };
    };
  };
}
