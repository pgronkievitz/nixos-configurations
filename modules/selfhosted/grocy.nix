let
  servicename = "grocy";
  shortname = "gro";
in
{ config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "lscr.io/linuxserver/grocy:3.3.2";
        volumes = [ "/media/data/${servicename}:/config" ];
        environment = { TZ = "Europe/Warsaw"; };
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
          "--label=flame.type=app"
          "--label=flame.name=${servicename}"
          "--label=flame.url=https://${shortname}.lab.home"
          "--label=flame.icon=basket"
        ];
      };
    };
  };
}
