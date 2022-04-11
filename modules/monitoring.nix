{ ... }: {
  services.prometheus.exporters = {
    node.enable = true;
    systemd.enable = true;
    smartctl = {
      enable = true;
      devices = [ "/dev/nvme0n1" "/dev/sda" "/dev/sdb" ];
      user = "root";
    };
  };
  services.cadvisor = {
    enable = true;
    port = 8081;
    listenAddress = "0.0.0.0";
  };
}
