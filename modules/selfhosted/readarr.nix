let
  servicename = "readarr";
  shortname = "read";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "lscr.io/linuxserver/readarr:0.1.1-nightly";
        volumes = [
          "/media/data/${servicename}/config:/config"
          "/media/data/${servicename}/books:/books"
          "/media/data/${servicename}/downloads:/downloads"
        ];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.xyz`,`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
        ];
      };
    };
  };
}
