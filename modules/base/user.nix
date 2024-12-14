{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  hardware.pulseaudio.enable = false;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  options.home.enable = lib.mkEnableOption "enables home modules";

  config = lib.mkIf config.user.base.user.enable {
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
        extraGroups = ["networkmanager" "wheel" "video" "audio" "libvirtd" "docker" "bluetooth"];
        shell = pkgs.fish;
      };
    };

    home-manager = {
      users.ryanm = import ./home.nix;
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
    };
  };
}
