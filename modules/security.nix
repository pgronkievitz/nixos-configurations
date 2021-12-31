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
  };
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = false;
  };
  security.pam.u2f = {
    enable = true;
    authFile = "/home/pg/.config/Yubico/u2fkeys";
    control = "required";
  };
}
