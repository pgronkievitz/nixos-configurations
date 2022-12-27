let
  servicename = "transmission";
  shortname = "torrent";
in
{ config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "lscr.io/linuxserver/transmission:version-3.00-r6";
        ports = [ "51413:51413" "51413:51413/udp" ];
        environment = { TZ = "Europe/Warsaw"; };
        volumes = [
          "/media/data/${servicename}/config:/config"
          "/media/data/${servicename}/downloads:/downloads"
          "/media/data/${servicename}/watch:/watch"
        ];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
          "--label=traefik.http.services.${servicename}.loadbalancer.server.port=9091"
          "--label=flame.type=app"
          "--label=flame.name=${servicename}"
          "--label=flame.url=https://${shortname}.lab.home"
          "--label=flame.icon=cloud-download"
          "--network=torrenting"
        ];
      };
    };
  };
}
