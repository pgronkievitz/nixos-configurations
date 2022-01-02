{
  services.nginx.virtualHosts."ca.gronkiewicz.xyz" = {
    addSSL = true;
    root = "/var/www/ca.gronkiewicz.xyz";
    sslCertificateKey = "/media/data/certs/ca/key.pem";
    sslCertificate = "/media/data/certs/ca/crt.pem";
  };
}
