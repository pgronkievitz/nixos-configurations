let
  pg =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICAbvEeFqXTFAXkYYvC5WTguYRgYrFa//kCfSdRu5SRK pg@artemis";
  users = [ pg ];

  apollo =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAGHoqKFSGiw0pdUPb5kIZ3L829rmnNZniWy3rnHdiYd";
  dart =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFCId/P0wNHN0rbdELDTvFD5kvtqSlDrpPLtHsYlOLkj pg@dart";
  systems = [ apollo dart ];
in { "cloudflare.age".publicKeys = users ++ systems; }
