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
    MIIDVDCCAjygAwIBAgIUZReotbfgd+u+CIUpETPwIX6nEXEwDQYJKoZIhvcNAQEL
    BQAwGTEXMBUGA1UEAwwOR3JvbmtpZXdpY3ogQ0EwHhcNMjIwMTAyMTkyNDI5WhcN
    MzExMjMxMTkyNDI5WjAZMRcwFQYDVQQDDA5Hcm9ua2lld2ljeiBDQTCCASIwDQYJ
    KoZIhvcNAQEBBQADggEPADCCAQoCggEBALby8dw2vfeCT5UarFQ2XR8wz60rQtiK
    OXELKOur21J19pzkqlYDBQmv19AZBhXlhjXZhcC6d71Bv30FIzVM1CdxlBL1t7kw
    EfAUio/NgYURLFOboSQomp0KwrhZxMLna3FZj9mkPWg+L2ayzECqtYXjvfXBYdf4
    xR8EyaeTFM2vT7aIjSzKmazPKOBM9HYcVZEqCyn8ttZK9d8TGoIAmJUKCG7T4y/P
    zfivoXmjR8guiVLab0o9DbYQndfcvrQOD6ZYJ8YYvfOkleHAi8Mru5zGNINl7Plq
    0iAIE80XMRTYh0W8ZQXyW+W951okB+oLcfQtUt1xBk26aCOtD1//XhMCAwEAAaOB
    kzCBkDAdBgNVHQ4EFgQUQxyyYzk/jZ5SOyqS15/qMpl6Zp0wVAYDVR0jBE0wS4AU
    QxyyYzk/jZ5SOyqS15/qMpl6Zp2hHaQbMBkxFzAVBgNVBAMMDkdyb25raWV3aWN6
    IENBghRlF6i1t+B3674IhSkRM/AhfqcRcTAMBgNVHRMEBTADAQH/MAsGA1UdDwQE
    AwIBBjANBgkqhkiG9w0BAQsFAAOCAQEAHgeyfJvCbJmyk5b9lv2OtyKuw0GsRMZK
    ah+a1nMJKEyWeYRRW8ekFPUozWzz1tWZeo9X1Zj7h8tZK7qNL4sKCjlD88KRFeIC
    p3309kuynjZwq7dKJcCid5Q09VUZxnzUoG+FH0Uw0BS2mQ/P9a+EYjGHSLiW3h+z
    hs4vVw5LBzn1Id+huDfwnP7xY0DVI4zQAZSLUhM4HuHMtV9Px4t2UhGrwny+EDA9
    byauZEVW1G+trj+jDd+DE0a+AfrdIPuyUlPFTV2Rt8jt9iPKNI+gtn9Mh8ToBnWf
    Hz/CpJYmjUO4mzUkMp7ZXmIz041USIQeTTyhM/g7V2DDx+12F3jwlw==
    -----END CERTIFICATE-----
  ''];
}
