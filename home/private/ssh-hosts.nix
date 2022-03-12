{ config, lib, pkgs, ... }: {
  programs.ssh = {
    enable = true;
    serverAliveInterval = 20;
    matchBlocks = {
      "apollo" = {
        hostname = "100.85.251.69";
        user = "pg";
        port = 14442;
      };
      "dart" = {
        hostname = "100.95.47.112";
        user = "pg";
        port = 14442;
      };
      "hubble" = {
        hostname = "100.111.43.19";
        user = "pg";
        port = 14442;
      };
      "nextcloud" = {
        hostname = "mini01.mikr.us";
        user = "root";
        port = 10127;
      };
    };
  };
}
