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
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.xyz`,`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
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
