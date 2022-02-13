let
  servicename = "restic";
  shortname = "restic";
  port = "11001";
in { config, ... }: {
  services.restic.server = {
    enable = true;
    dataDir = "/media/backups";
    prometheus = true;
    listenAddress = "127.0.0.1:${port}";
    extraFlags = [ "--no-auth" ];
  };
  services.traefik.dynamicConfigOptions = {
    http = {
      routers = {
        restic = {
          rule = "Host(`${shortname}.gronkiewicz.xyz`,`${shortname}.lab.home`)";
          tls = true;
          service = "restic";
        };
      };
      services = {
        restic = {
          loadBalancer = { servers = [{ url = "http://127.0.0.1:${port}"; }]; };
        };
      };
    };
  };
}
