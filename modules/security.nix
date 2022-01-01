{
  networking = {
    networkmanager.enable = true;
    useDHCP = false;
    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" "virbr0" ];
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
    extraConfig = ''
      AllowTcpForwarding no
      ClientAliveCountMax 2
      Compression no
      MaxAuthTries 3
      MaxSessions 2
      TCPKeepAlive no
      AllowAgentForwarding no
    '';
    logLevel = "VERBOSE";
    banner = ''
      UNAUTHORIZED CONNECTIONS ARE FORBIDDEN AND WILL BE REPORTED
    '';
  };
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = false;
  };
}
