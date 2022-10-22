let
  servicename = "jabber";
  shortname = "jabber";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "ghcr.io/processone/ejabberd:22.05";
        environment = {
          TZ = "Europe/Warsaw";
          GENERIC_TIMEZONE = "Europe/Warsaw";
        };
        volumes = [
          "/media/data/${servicename}/database:/opt/ejabberd/database"
          "/media/data/${servicename}/conf/ejabberd.yml:/opt/ejabberd/conf/ejabberd.yml"
          "/media/data/${servicename}/logs:/opt/ejabberd/logs"
          "/media/data/${servicename}/upload:/opt/ejabberd/upload"
        ];
        ports = [
          "5222:5222" # XMPP
          "5269:5269" # XMPP fed
        ];
#       extraOptions = [
#         "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.dev`)"
#         "--label=traefik.http.routers.${servicename}.tls=true"
#         "--label=traefik.http.routers.${servicename}.tls.certresolver=letsencrypt"
#         "--label=traefik.http.services.${servicename}.loadbalancer.server.port=5280"
#       ];
      };
    };
  };
}
