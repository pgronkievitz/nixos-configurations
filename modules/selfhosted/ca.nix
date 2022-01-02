{ pkgs, config, ... }:
let shortname = "ca";
in {
  services.nginx.virtualHosts."${shortname}.gronkiewicz.xyz" = {
    addSSL = true;
    root = "/var/www/${shortname}.gronkiewicz.xyz";
    sslCertificateKey = "/media/data/certs/${shortname}/key.pem";
    sslCertificate = "/media/data/certs/${shortname}/crt.pem";
    extraConfig = "ssl_password_file ${config.age.secrets.ssl.path};";
  };
  environment.systemPackages = [ pkgs.openssl pkgs.easyrsa ];
}
