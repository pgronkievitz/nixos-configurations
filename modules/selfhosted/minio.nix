{ config, lib, pkgs, ... }:

{
  services.minio = {
    enable = true;
    dataDir = ["/media/data/minio"];
  };
  services.prometheus.exporters.minio = {
    enable = true;
    minioAddress = "http://100.95.47.112:9000";
  };
}
