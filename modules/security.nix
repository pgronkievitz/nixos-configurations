{ pkgs, lib, ... }: {
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
  environment.systemPackages = [ pkgs.chkrootkit ];
  security.pki.certificates = [''
    -----BEGIN CERTIFICATE-----
    MIIDETCCApegAwIBAgIRAIjs/gXVn+PX7SKSN2eacUQwCgYIKoZIzj0EAwMwUTEY
    MBYGA1UECgwPZ3JvbmtpZXdpY3oueHl6MTUwMwYDVQQDDCxncm9ua2lld2ljei54
    eXogUm9vdCBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0yMjAxMDEwMDAwMDBa
    Fw0zMjAxMDMwMDAwMDBaMFExGDAWBgNVBAoMD2dyb25raWV3aWN6Lnh5ejE1MDMG
    A1UEAwwsZ3JvbmtpZXdpY3oueHl6IFJvb3QgQ2VydGlmaWNhdGlvbiBBdXRob3Jp
    dHkwdjAQBgcqhkjOPQIBBgUrgQQAIgNiAAQQ5qVz2aRfjYxiZ5tEzGZ3K0Jke0xA
    nswk5r78vFSn+Kud8fU+/4epPR/UmnQPfaulaDFAG3tgURT3NXcldXjD1oRDS/mQ
    sj8JIIMjlBekBn1lw7yWYYAcuhIWTCToPjijggExMIIBLTAPBgNVHRMBAf8EBTAD
    AQH/MA4GA1UdDwEB/wQEAwIBBjBEBgNVHR4BAf8EOjA4oDYwEYIPZ3JvbmtpZXdp
    Y3oueHl6MAWCA2xhbjAHggVvbmlvbjARgQ9ncm9ua2lld2ljei54eXowHQYDVR0O
    BBYEFBrrkODskjrKcw/2QMpMM+wqTnyAMEEGA1UdEQQ6MDiGGmh0dHA6Ly9jYS5n
    cm9ua2lld2ljei54eXovgRpjZXJ0bWFzdGVyQGdyb25raWV3aWN6Lnh5ejAfBgNV
    HSMEGDAWgBQa65Dg7JI6ynMP9kDKTDPsKk58gDBBBgNVHRIEOjA4hhpodHRwOi8v
    Y2EuZ3JvbmtpZXdpY3oueHl6L4EaY2VydG1hc3RlckBncm9ua2lld2ljei54eXow
    CgYIKoZIzj0EAwMDaAAwZQIxANTZejdKc3OEg1tI9IHDL+EAURhbUU6exLwm3DH4
    tzIqH1OUxT8j3PG8oNKRj8jTRgIwfP1qrdIOG8/ogEkR8Sz9+nT5whuKfDQDqd+B
    HHDJ38m6Fjfbr+AkCsKzPfZxpwhk
    -----END CERTIFICATE-----
       ''];
}
