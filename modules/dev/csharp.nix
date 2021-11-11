{ config, lib, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.mono pkgs.dotnet-sdk_5 ];
}
