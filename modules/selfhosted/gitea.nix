let
  servicename = "gitea";
  shortname = "git";
  port = "9001";
in {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "gitea/gitea:1.15.6-rootless";
        ports = [ "${port}:3000" ];
        # login = {
        #   username = "pgronkievitz";
        #   registry = "https://docker.io";
        #   passwordFile = "/home/pg/.local/dockerhub-password.txt";
        # };
      };
    };
  };
  services.nginx.virtualHosts = {
    "${shortname}.gronkiewicz.xyz" = {
      enableACME = true;
      forceSSL = true;
      credentialsFile = "/etc/certs/credentials.sh";
      locations."/" = {
        proxyPass = "http://127.0.0.1:${port}";
        extraConfig = "proxy_ssl_server_name on;"
          + "proxy_pass_header Authorization;";
      };
      serverAliases = [
        "www.${shortname}.gronkiewicz.xyz"
        "${servicename}.gronkiewicz.xyz"
        "www.${servicename}.gronkiewicz.xyz"
      ];
    };
  };
  security.acme.certs."${shortname}.gronkiewicz.xyz" = {
    extraDomainNames = [
      "www.${shortname}.gronkiewicz.xyz"
      "${servicename}.gronkiewicz.xyz"
      "www.${servicename}.gronkiewicz.xyz"
    ];
    dnsProvider = "cloudflare";
    dnsResolver = "1.1.1.1:53";
    credentialsFile = ./credentials.sh;
  };
}
