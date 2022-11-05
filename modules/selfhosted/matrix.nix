let
  servicename = "dendrite";
  shortname = "matrix";
in { pkgs, config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "matrixdotorg/dendrite-monolith:v0.10.7";
        cmd = [
          "--tls-cert=server.crt"
          "--tls-key=server.key"
        ];
        volumes = [
          "/media/data/${servicename}/data:/var/dendrite/media"
          "/media/data/${servicename}/config:/etc/dendrite"
        ];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.dev`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
          "--label=traefik.http.routers.${servicename}.tls.certresolver=letsencrypt"

          "--label=traefik.http.services.${servicename}.loadbalancer.server.port=8008"
          "--network=${servicename}"
        ];
        ports = [ "8448:8448" ];
        dependsOn = [ "${servicename}-db" ];
      };
      "${servicename}-db" = {
        image = "postgres:14.5-alpine";
        volumes = [
          "/media/data/${servicename}/db/data:/var/lib/postgresql/data"
          "/media/data/${servicename}/db/create_db.sh:/docker-entrypoint-initdb.d/20-create_db.sh:ro"
        ];
        extraOptions = [ "--network=${servicename}" ];
        environmentFiles = [ config.age.secrets.matrixdb.path ];
      };
    };
  };
}
