{ pkgs, ... }: {
  services.xserver.videoDrivers = [ "nvidia" "amdgpu" ];
  # hardware.nvidia.modesetting.enable = true;
}
