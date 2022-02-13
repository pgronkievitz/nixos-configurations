let
  servicename = "gitea";
  shortname = "git";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "gitea/gitea:1.16.0";
        volumes = [ "/media/data/${servicename}:/data" ];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.xyz`,`${shortname}.lab.home`)"
          "--label=traefik.http.services.${servicename}.loadbalancer.server.port=3000"
          "--label=traefik.http.routers.${servicename}.tls=true"
          "--label=traefik.tcp.routers.${servicename}-ssh.rule=HostSNI(`*`)"
          "--label=traefik.tcp.routers.${servicename}-ssh.entrypoints=ssh"
          "--label=traefik.tcp.services.${servicename}-ssh.loadbalancer.server.port=2222"
        ];
      };
    };
  };
}
