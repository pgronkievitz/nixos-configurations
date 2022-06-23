let
  servicename = "wallabag";
  shortname = "wb";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "wallabag/wallabag:2.5.1";
        volumes = [ "/media/data/${servicename}:/var/www/wallabag/data" ];
        environment = {
          "SYMFONY__ENV__DOMAIN_NAME" = "https://${shortname}.lab.home";
        };
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.xyz`,`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
        ];
      };
    };
  };
}
