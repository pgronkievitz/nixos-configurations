{ ... }: {
  services.prometheus.exporters = {
    node.enable = true;
    systemd.enable = true;
    smartctl = {
      enable = true;
      devices = [ "/dev/nvme0n1" "/dev/sda" "/dev/sdb" ];
    };
  };
}
