{ config, lib, pkgs, ... }: {
  programs.ssh = {
    enable = true;
    serverAliveInterval = 20;
    matchBlocks = {
      "tilde" = {
        hostname = "tilde.team";
        user = "pg";
      };
      "mikrus" = {
        hostname = "srv09.mikr.us";
        user = "pg";
        port = 10130;
      };
      "apollo" = {
        hostname = "100.85.251.69";
        user = "pg";
      };
      "dart" = {
        hostname = "100.95.47.112";
        user = "pg";
      };
    };
  };
}
