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
      entryPoints.ssh.address = ":22";
      metrics.prometheus.addRoutersLabels = true;
    };
    dynamicConfigOptions = {
      tls.stores.default.defaultCertificate = {
        certFile = "/media/data/ca/cert.pem";
        keyFile = "/media/data/ca/key.pem";
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 22 ];
}
