{
  imports = [ ./git-signing.nix ./ssh-hosts.nix ./git-sync.nix ];
  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };
}
