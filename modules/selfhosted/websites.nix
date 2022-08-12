let nginxver="1.23.1-alpine"; in {
  virtualisation.oci-containers = {
    containers = {
      "gronkiewi-cz" = let servicename = "gronkiewi.cz"; in {
        image = "nginx:${nginxver}";
        volumes = [ "/media/data/web/${servicename}:/usr/share/nginx/html" ];
        extraOptions = [
          "--label=traefik.http.routers.gronkiewi-cz.rule=Host(`${servicename}`)"
        ];
      };
      "gronkiewicz-dev" = let servicename = "gronkiewicz.dev"; in {
        image = "nginx:${nginxver}";
        volumes = [ "/media/data/web/${servicename}:/usr/share/nginx/html" ];
        extraOptions = [
          "--label=traefik.http.routers.gronkiewicz-dev.rule=Host(`${servicename}`)"
        ];
      };
    };
  };
}
