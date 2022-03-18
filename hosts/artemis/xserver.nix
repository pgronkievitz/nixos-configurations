{ pkgs, ... }: { services.xserver.videoDrivers = [ "nvidia" "amdgpu" ]; }
