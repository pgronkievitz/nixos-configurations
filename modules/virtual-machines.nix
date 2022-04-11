{ pkgs, ... }: {
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = false;
      ovmf.enable = true;
    };
    onBoot = "ignore";
    onShutdown = "shutdown";
  };
  environment.systemPackages = [ pkgs.virtmanager pkgs.lxc ];
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
  virtualisation.lxd.enable = true;
}
