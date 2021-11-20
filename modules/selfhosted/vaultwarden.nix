let
  servicename = "vaultwarden";
  shortname = "vault";
  port = 9001;
in {
  virtualisation.oci-containers = {
    containers = { vaultwarden = { image = ""; }; };
  };
}
