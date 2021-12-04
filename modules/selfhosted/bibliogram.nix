let
  servicename = "bibliogram";
  shortname = "bib";
  port = "9301";
  domains = [
    "www.${shortname}.gronkiewicz.xyz"
    "${servicename}.gronkiewicz.xyz"
    "www.${servicename}.gronkiewicz.xyz"
  ];
in {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "cloudrac3r/bibliogram:latest";
        ports = [ "${port}:10407" ];
        environment = {
          "SYMFONY__ENV__DOMAIN_NAME" =
            "https://${servicename}.gronkiewicz.xyz";
        };
      };
    };
  };
  services.nginx.virtualHosts = {
    "${shortname}.gronkiewicz.xyz" = {
      useACMEHost = "${shortname}.gronkiewicz.xyz";
      forceSSL = true;
      locations."/".proxyPass = "http://127.0.0.1:${port}";
      serverAliases = domains;
    };
  };
  security.acme.certs."${shortname}.gronkiewicz.xyz" = {
    extraDomainNames = domains;
    dnsProvider = "cloudflare";
    credentialsFile = "/home/pg/credentials.sh";
  };
}
