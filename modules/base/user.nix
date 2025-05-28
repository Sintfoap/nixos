{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  options.home.enable = lib.mkEnableOption "enables home modules";

  config = lib.mkIf config.base.user.enable {
    hardware.pulseaudio.enable = false;
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    hardware.nvidia.prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:0:1:0";
    };
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    programs = {
      fish.enable = true;
      nh = {
        enable = true;
        clean.enable = true;
        flake = "/home/ryanm/nixos";
      };
    };

    users = {
      users.ryanm = {
        isNormalUser = true;
        description = "Ryan Moffitt";
        extraGroups = ["networkmanager" "wheel" "video" "audio" "libvirtd" "docker" "bluetooth" "dialout" "keyboard"];
        shell = pkgs.fish;
      };
    };

    home-manager = {
      users.ryanm = import ../home.nix;
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
    };
  };
}
