{ pkgs, ... }: {

  virtualisation.libvirtd = {
    enable = true;
    qemu.package = pkgs.qemu_kvm;
    qemu.ovmf.enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
  };
  environment.systemPackages = [ pkgs.virtmanager ];
  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
    enableHardening = true;
  };
}
