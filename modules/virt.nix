{ pkgs, ... }: {

  virtualisation.libvirtd = {
    enable = true;
    qemuPackage = pkgs.qemu_kvm;
    qemuOvmf = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
  };
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
  };
}
