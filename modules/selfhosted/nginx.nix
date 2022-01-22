{
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "patryk@gronkiewicz.dev";
  };
}
