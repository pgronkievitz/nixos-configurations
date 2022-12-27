let
  servicename = "technitium";
  shortname = "dns";
in
{ config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "technitium/dns-server:10.0.1";
        ports = [ "53:53/tcp" "53:53/udp" ];
        volumes = [
          "/media/data/${servicename}:/etc/dns/config"
        ];
        environment = {
          DNS_SERVER_DOMAIN = "dns.lab.home";
          DNS_SERVER_RECURSION = "Allow";
          DNS_SERVER_FORWARDERS = "1.1.1.1,9.9.9.9";
        };
        environmentFiles = [ config.age.secrets.technitium.path ];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.lab.home`)"
          "--label=traefik.http.services.${servicename}.loadbalancer.server.port=5380"
          "--label=traefik.http.routers.${servicename}.tls=true"
          "--label=flame.type=app"
          "--label=flame.name=${servicename}"
          "--label=flame.url=https://${shortname}.lab.home"
          "--label=flame.icon=dns"
        ];
      };
    };
  };
}
