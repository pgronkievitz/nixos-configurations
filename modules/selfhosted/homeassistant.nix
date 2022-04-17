let
  servicename = "homeassistant";
  shortname = "ha";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "ghcr.io/home-assistant/home-assistant:2022.4.5";
        volumes = [ "/media/data/${servicename}:/config" "/etc/localtime:/etc/localtime:ro"];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.xyz`,`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
          "--privileged"
          "--network=host"
        ];

      };
    };
  };
}
