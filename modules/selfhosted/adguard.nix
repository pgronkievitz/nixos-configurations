let
  servicename = "adguard";
  shortname = "dns";
  port = 10001;
  domains = [ "${servicename}.gronkiewicz.xyz" ];
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "adguard/adguardhome:v0.107.2";
        ports = [
          "${builtins.toString port}:80"
          "3000:3000/tcp"
          # regular DNS
          "53:53/tcp"
          "53:53/udp"
          # DNSCrypt
          "5443:5443/tcp"
          "5443:5443/udp"
          # DoQ
          "784:784/udp"
          "853:853/udp"
          "8853:8853/udp"
          # DoT
          "853:853/tcp"
        ];
        volumes = [ "/media/data/${servicename}:/opt/adguardhome" ];
        environment = { TZ = "Europe/Warsaw"; };
      };
    };
  };
  services.nginx.virtualHosts = {
    "${shortname}.gronkiewicz.xyz" = {
      useACMEHost = "${shortname}.gronkiewicz.xyz";
      forceSSL = true;
      locations."/".proxyPass = "http://127.0.0.1:${builtins.toString port}";
      serverAliases = domains;
    };
  };
  security.acme.certs."${shortname}.gronkiewicz.xyz" = {
    extraDomainNames = domains;
    dnsProvider = "cloudflare";
    credentialsFile = config.age.secrets.cloudflare.path;
  };
}
