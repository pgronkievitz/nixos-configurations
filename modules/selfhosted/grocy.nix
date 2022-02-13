let
  servicename = "grocy";
  shortname = "gro";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "lscr.io/linuxserver/grocy:3.1.3";
        volumes = [ "/media/data/${servicename}:/config" ];
        environment = { TZ = "Europe/Warsaw"; };
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.xyz`,`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
        ];
      };
    };
  };
}
