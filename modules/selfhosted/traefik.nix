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
      certificatesResolvers.letsencrypt.acme = {
        email = "patryk@gronkiewicz.dev";
        storage = "/media/data/acme.json";
        httpChallenge.entryPoint = "http";

      };
      metrics.prometheus.addRoutersLabels = true;
    };
    dynamicConfigOptions = {
      tls.certificates = [
        {
          certFile = "/media/data/ca/cert.pem";
          keyFile = "/media/data/ca/key.pem";
        }
      ];
    };
  };
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
