{ pkgs, ... }: {
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      ovmf.enable = true;
    };
    onBoot = "ignore";
    onShutdown = "shutdown";
  };
  environment.systemPackages = [ pkgs.virtmanager ];
  services.webdav = {
    enable = true;
    settings = {
      address = "192.168.122.1";
      port = 9999;
      scope = "/home/pg/Public";
      modify = true;
      auth = false;
    };
    user = "pg";
    group = "users";
  };
}
