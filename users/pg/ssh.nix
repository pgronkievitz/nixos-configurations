{ config, lib, pkgs, ... }:

{
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
        hostname = "100.80.207.36";
        user = "pg";
      };
      "cass" = {
        hostname = "164.90.171.118";
        user = "root";
      };
      "testenv" = {
        hostname = "192.168.100.160";
        user = "ubuntu";
      };
    };
  };
}
