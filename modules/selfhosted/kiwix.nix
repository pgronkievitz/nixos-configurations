let
  servicename = "kiwix";
  shortname = "wiki";
in
{ config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "kiwix/kiwix-serve:3.4.0";
        volumes = [
          "/media/data/${servicename}:/data"
        ];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
          "--label=flame.type=app"
          "--label=flame.name=${servicename}"
          "--label=flame.url=https://${shortname}.lab.home"
          "--label=flame.icon=earth"
        ];
        cmd = [
          "archlinux_en_all_maxi_2022-04.zim"
          "gentoo_en_all_maxi_2021-03.zim"
          "wikipedia_en_all_maxi_2022-05.zim"
        ];
      };
    };
  };
}
