{ pkgs, ... }: {

  virtualisation.libvirtd = {
    enable = true;
    qemu.package = pkgs.qemu_kvm;
    qemu.ovmf.enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
  };
  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
    enableHardening = true;
  };
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
  };
}
