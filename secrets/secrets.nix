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
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKgsN7S+Q/BeqgHhvNmuctN3jFV1Q4fiJdbL9LWdwXZi";
  systems = [ artemis apollo dart ];
  servers = [ apollo dart hubble ];
  laptop = [ artemis pg ];
in {
  "ssl.age".publicKeys = servers ++ users;
  "ncdb.age".publicKeys = users ++ [ dart ];
  "ncmonitoring.age".publicKeys = users ++ [ dart ];
  "photoprismdb.age".publicKeys = users ++ [ dart ];
  "photoprism.age".publicKeys = users ++ [ dart ];
  "friendicadb.age".publicKeys = users ++ [ hubble ];
  "friendica.age".publicKeys = users ++ [ hubble ];
}
