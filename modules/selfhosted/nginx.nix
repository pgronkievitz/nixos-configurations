{
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    group = "acme";
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "patryk@gronkiewicz.dev";
  };
}
