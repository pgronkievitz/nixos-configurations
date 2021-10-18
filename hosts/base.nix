{ lib, pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovim
    zsh
    cachix
    networkmanager
    networkmanagerapplet
    networkmanager_openvpn
    tailscale
    OVMF
    OVMFFull
  ];
  services.tailscale.enable = true;
  programs.mtr.enable = true;
  users.mutableUsers = false;
  users.users.pg = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "libvirtd" "podman" ];
    shell = pkgs.zsh;
    description = "Patryk Gronkiewicz";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJQfo481KqK1LXCwZdz6sDvEbgxoL0cqV3n0J+nbTjaZ u0_a313@localhost"
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIDH7219zlzbwGZxSHkbKWFZ6HlgYF352/88uyhapeMNRAAAABHNzaDo= pg@artemis"
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIAVmIuEGVOre3GqyZydZiZ/BKYFLSLqU9qZLmIn6BN1ZAAAABHNzaDo= pg@artemis"
    ];
    hashedPassword =
      "$6$spoDBwr2hANMIaZ$joTTa3EpgdT2U.eOisBOEr26WasNdiVj39J3f4DcRkG48ubiobsdIiskgdreGl2EiW4JbpKFcwp5ByjjkfgmJ/";
  };
}
