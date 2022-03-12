{ config, lib, pkgs, ... }: {
  programs.ssh = {
    enable = true;
    serverAliveInterval = 20;
    matchBlocks = {
      "mikrus" = {
        hostname = "srv09.mikr.us";
        user = "pg";
        port = 10130;
      };
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
    };
  };
}
