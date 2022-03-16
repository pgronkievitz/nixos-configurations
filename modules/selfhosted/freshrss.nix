let
  servicename = "freshrss";
  shortname = "rss";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "lscr.io/linuxserver/freshrss:1.19.2";
        environment = { TZ = "Europe/Warsaw"; };
        volumes = [ "/media/data/${servicename}:/config" ];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.xyz`,`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
        ];
      };
    };
  };
}
