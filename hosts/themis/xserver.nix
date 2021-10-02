{ config, lib, pkgs, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in {
  services.xserver = {
    enable = true;
    videoDrivers = [ "modesetting" "nvidia" ];
    desktopManager = { xterm.enable = false; };
    displayManager = {
      sddm.enable = true;
      defaultSession = "none+qtile";
    };
    windowManager.qtile.enable = true;
    layout = "pl";
    xkbOptions = "caps:swapescape";
    libinput.enable = true;
  };
  hardware.nvidia.prime = {
    offload.enable = true;
    amdgpuBusId = "PCI:05:00:0";
    nvidiaBusId = "PCI:01:00:0";
  };
}
