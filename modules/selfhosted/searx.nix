let
  servicename = "searxng";
  shortname = "search";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "searxng/searxng:2022.04.23-ca1a5f9d";
        environment = {
          BASE_URL = "https://${shortname}.lab.home";
          INSTANCE_NAME= shortname;
        };
        volumes = [ "/media/data/${servicename}:/etc/searxng" ];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.xyz`,`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
        ];
      };
    };
  };
}
