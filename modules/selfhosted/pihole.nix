let
  servicename = "pihole";
  shortname = "dns";
  port = 10001;
  domains = [
    "${servicename}.gronkiewicz.xyz"
    "${shortname}.gronkiewicz.xyz"
    "${shortname}.local"
  ];
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "pihole/pihole:2022.01.1";
        ports = [
          "127.0.0.1:${builtins.toString port}:80"
          "100.111.43.19:${builtins.toString port}:80"
          # regular DNS
          "53:53/tcp"
          "53:53/udp"
        ];
        volumes = [
          "/media/data/${servicename}/dnsmasq:/etc/pihole"
          "/media/data/${servicename}/pihole:/etc/dnsmasq.d"
        ];
        environment = { TZ = "Europe/Warsaw"; };
      };
    };
  };
  services.nginx.virtualHosts = {
    "${shortname}.gronkiewicz.xyz" = {
      forceSSL = true;
      locations."/".proxyPass = "http://127.0.0.1:${builtins.toString port}";
      serverAliases = domains;
      sslCertificateKey = "/media/data/certs/${shortname}/key.pem";
      sslCertificate = "/media/data/certs/${shortname}/crt.pem";
    };
  };
}
