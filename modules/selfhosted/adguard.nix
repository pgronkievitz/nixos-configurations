let
  servicename = "adguard";
  shortname = "dns";
  port = 10001;
  domains = [
    "www.${shortname}.gronkiewicz.xyz"
    "${servicename}.gronkiewicz.xyz"
    "www.${servicename}.gronkiewicz.xyz"
  ];
in { config, ... }: {
  services.adguardhome = {
    enable = true;
    port = port;
    host = "0.0.0.0";
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
