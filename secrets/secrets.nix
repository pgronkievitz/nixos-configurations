let
  pg =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICAbvEeFqXTFAXkYYvC5WTguYRgYrFa//kCfSdRu5SRK pg@artemis";
  users = [ pg ];

  apollo =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAGHoqKFSGiw0pdUPb5kIZ3L829rmnNZniWy3rnHdiYd";
  dart =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHP69bvkDQefQZqUWNOqULeh5oiQ2xQJmHm5Mw0+/XeE";
  hubble =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFXwGIHC62SpqrKZ3CVxqEp05iM1BcUgcwpIzMEdAIRJ";
  artemis =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGA+womWFzFqOsX9Scz/zOXRabLErDjEzIFHrUMjePOm";
  systems = [ artemis apollo dart ];
  servers = [ apollo dart hubble ];
  private = [ artemis pg ];
in {
  "cloudflare.age".publicKeys = users ++ servers;
  "artemis/bkp.age".publicKeys = private;
  "artemis/bkp-env.age".publicKeys = private;
}
