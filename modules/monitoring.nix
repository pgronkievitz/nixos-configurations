{ ... }: {
  services.prometheus.exporters = {
    node.enable = true;
    systemd.enable = true;
    smartctl.enable = true;
  };
}
