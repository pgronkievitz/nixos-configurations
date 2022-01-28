{
  imports = [
    ./git-signing.nix
    ./ssh-hosts.nix
    ./git-sync.nix
    ./email.nix
    ./office.nix
  ];
  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };
}
