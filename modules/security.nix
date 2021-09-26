{
  networking = {
    networkmanager.enable = true;
    useDHCP = false;
    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
    };
  };
  security.auditd.enable = true;
  security.audit.enable = true;
  security.audit.rules = [ "-a exit,always -F arch=b64 -S execve" ];
  security.sudo.execWheelOnly = true;
  nix.trustedUsers = [ "root" "pg" ];

  # SSH

  programs.ssh.startAgent = true;
  services.openssh = {
    enable = true;
    allowSFTP = false;
    passwordAuthentication = false;
    permitRootLogin = "no";
    listenAddresses = [{
      addr = "100.79.65.104";
      port = 22;
    }];
  };
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = false;
  };
}
