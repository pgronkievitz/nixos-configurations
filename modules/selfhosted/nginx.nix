{
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };
  security.acme = {
    acceptTerms = true;
    email = "patryk@gronkiewicz.dev";
    certs."gronkiewicz.xyz" = {
      dnsProvider = "cloudflare";
      dnsResolver = "1.1.1.1:53";
      credentialsFile = ./credentials.sh;
    };
  };
}
