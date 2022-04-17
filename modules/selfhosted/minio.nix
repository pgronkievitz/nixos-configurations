{ config, lib, pkgs, ... }:

{
  services.minio = {
    enable = true;
    dataDir = ["/media/data/minio"];
  };
}
