{ pkgs, lib, ... }: {
  networking = {
    networkmanager.enable = true;
    networkmanager.plugins = [ pkgs.networkmanager-fortisslvpn ];
    useDHCP = false;
    firewall = {
      enable = true;
      trustedInterfaces = [ "docker0" "tailscale0" "virbr0" ];
      checkReversePath = "loose";
    };
  };
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
  environment.systemPackages = [ pkgs.chkrootkit pkgs.lxsession ];
  security.pki.certificates = [''
    -----BEGIN CERTIFICATE-----
    MIIDQjCCAiqgAwIBAgIUNA2iTcE/V5bNW6b1e0v/o/OmhfcwDQYJKoZIhvcNAQEL
    BQAwEzERMA8GA1UEAwwIQ2hhbmdlTWUwHhcNMjIwMjExMDgwMzAxWhcNMzIwMjA5
    MDgwMzAxWjATMREwDwYDVQQDDAhDaGFuZ2VNZTCCASIwDQYJKoZIhvcNAQEBBQAD
    ggEPADCCAQoCggEBAMoTLbjSVwh2zX4M3oG80m81q8p2pbeZ312K2THBUmnAgE8Y
    4Ly+P58BpYaTimnirgXlWiWn23Iy4LnpsUEWiVFHg9BEe4k8wG5GVwbF9bdrVFFK
    3aioUFEg3V9Nf3JczlK2YRs680RtPHKYES7z8VfagDENgPsYxYrYNHznrUtm86RR
    52eHk6A6la4PyFJSUSVyRf2qmWxXPCZszabRU/mNSabSlJG/BXZDXyyltxDuzcy9
    4TN1yMR/M5gqXkG2IYBYt8au9tM4lGfvbJ2kQKFFnPP/f2ur1dIQ9WPJ9QD7iSQN
    CADxTjWA/vDeR9KBTNS9sWz5iPhCs7wTEcaOM6ECAwEAAaOBjTCBijAdBgNVHQ4E
    FgQU1+h4QXF6YOrEBaXTx9+JtnnHJN8wTgYDVR0jBEcwRYAU1+h4QXF6YOrEBaXT
    x9+JtnnHJN+hF6QVMBMxETAPBgNVBAMMCENoYW5nZU1lghQ0DaJNwT9Xls1bpvV7
    S/+j86aF9zAMBgNVHRMEBTADAQH/MAsGA1UdDwQEAwIBBjANBgkqhkiG9w0BAQsF
    AAOCAQEAf4bEMHWgoH8Sp84Cu/nTHzLJUs/oz+CGK2NpxUs3Ut9mLTseAe2G1VPp
    vs4g/m+WG7SB5sclAFGFvH2MZech8zGy/PeWIcldsJY9ephsNYOB7BVUwrRN4ZZI
    WyRBqWt83I5xhNQKIdLjv/BYXcErn/nZRNzRYejYj/SxVAuX4rR+zUyNE5GJ51Pq
    5TLWQP37sJVmtyG0ep+NzrQdbxQYl4UeiGWaYRnbKFVyFUkCovmoepF0IjUWV5lc
    j7dXhSFTrgmLP0N3t7tWI8jO+jRkYUlTzauj8dU8Gs7B617XLEk9hl8tv2OLvxUV
    YnW/M3nqnpgCj7EtzJ3XiE5Gj1Yr1w==
    -----END CERTIFICATE-----
  ''];
}
