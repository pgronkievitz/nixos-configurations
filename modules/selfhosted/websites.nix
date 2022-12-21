let nginxver = "1.23.3-alpine"; in
{
  virtualisation.oci-containers = {
    containers = {
      "gronkiewi-cz" = let servicename = "gronkiewi.cz"; in
        {
          image = "nginx:${nginxver}";
          volumes = [ "/media/data/web/${servicename}:/usr/share/nginx/html" ];
          extraOptions = [
            "--label=traefik.http.routers.gronkiewicz-dev.rule=Host(`${servicename}`)"
            "--label=traefik.http.routers.gronkiewicz-dev.tls=true"
            "--label=traefik.http.routers.gronkiewicz-dev.tls.certresolver=letsencrypt"
            "--label=traefik.http.services.gronkiewicz-dev.loadbalancer.server.port=80"
          ];
        };
      "gronkiewicz-dev" = let servicename = "gronkiewicz.dev"; in
        {
          image = "nginx:${nginxver}";
          volumes = [ "/media/data/web/${servicename}:/usr/share/nginx/html" ];
          extraOptions = [
            "--label=traefik.http.routers.gronkiewi-cz.rule=Host(`${servicename}`)"
            "--label=traefik.http.routers.gronkiewi-cz.tls=true"
            "--label=traefik.http.routers.gronkiewi-cz.tls.certresolver=letsencrypt"
            "--label=traefik.http.services.gronkiewi-cz.loadbalancer.server.port=80"
          ];
        };
    };
  };
}
