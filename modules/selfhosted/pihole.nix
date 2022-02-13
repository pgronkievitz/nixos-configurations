let
  servicename = "pihole";
  shortname = "dns";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "pihole/pihole:2022.01.1";
        ports = [ "100.111.43.19:9999:80" "53:53/tcp" "53:53/udp" ];
        volumes = [
          "/media/data/${servicename}/dnsmasq:/etc/pihole"
          "/media/data/${servicename}/pihole:/etc/dnsmasq.d"
        ];
        environment = { TZ = "Europe/Warsaw"; };
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.xyz`,`${shortname}.lab.home`)"
          "--label=traefik.http.services.${servicename}.loadbalancer.server.port=80"
          "--label=traefik.http.routers.${servicename}.tls=true"
        ];
      };
    };
  };
}
