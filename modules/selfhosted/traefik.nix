{
  services.traefik = {
    enable = true;
    group = "docker";
    staticConfigOptions = {
      api.insecure = true;
      providers.docker.exposedbydefault = true;
      entryPoints.http = {
        address = ":80";
        http.redirections.entryPoint = {
          to = "https";
          scheme = "https";
        };
      };
      entryPoints.https.address = ":443";
      metrics.prometheus.addRoutersLabels = true;
      certificatesResolvers.letsencrypt.acme = {
        email = "patryk@gronkiewicz.dev";
        storage = "/media/data/traefik/acme.json";
        httpChallenge.entrypoint = "https";
      };
    };
    dynamicConfigOptions = {
      tls.stores.default.defaultCertificate = {
        certFile = "/media/data/ca/cert.pem";
        keyFile = "/media/data/ca/key.pem";
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
