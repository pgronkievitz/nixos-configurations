let
  servicename = "adguard";
  shortname = "dns";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "adguard/adguardhome:v0.108.0-b.10";
        ports = [ "53:53/tcp" "53:53/udp" ];
        volumes = [
          "/media/data/${servicename}/work:/opt/adguardhome/work"
          "/media/data/${servicename}/conf:/opt/adguardhome/conf"
        ];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.xyz`,`${shortname}.lab.home`)"
          "--label=traefik.http.services.${servicename}.loadbalancer.server.port=80"
          "--label=traefik.http.routers.${servicename}.tls=true"
        ];
      };
    };
  };
}
