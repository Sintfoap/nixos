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
    hardware.opengl.enable = true; 
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
        extraGroups = ["networkmanager" "wheel" "video" "audio" "libvirtd" "docker" "bluetooth" "dialout" ];
        shell = pkgs.fish;
      };
    };

    home-manager = {
      users.ryanm = import ../home.nix;
      extraSpecialArgs = {inherit inputs;};
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
    };
  };
}
