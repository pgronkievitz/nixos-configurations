{ ... }: {
  services.prometheus.exporters = {
    node = {
      enable = true;
      openFirewall = true;
    };
    systemd.enable = true;
    smartctl.enable = true;
  };
}
