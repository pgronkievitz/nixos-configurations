let
  servicename = "vaultwarden";
  shortname = "vault";
  port = 9001;
in {
  virtualisation.oci-containers = {
    backend = "podman";
    containers = { vaultwarden = { image = ""; }; };
  };
}
