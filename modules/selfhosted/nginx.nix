{
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };
  security.acme = {
    acceptTerms = true;
    email = "patryk@gronkiewicz.dev";
  };
}
