{
  lib,
  config,
  ...
}: {
  imports = [
    ./base
    ./packages
    ./stylix.nix
    ./boot.nix
  ];

  options.omni.enable = lib.mkOption {default = true;};

  config = lib.mkIf config.omni.enable {
    base = {
      enable = lib.mkDefault true;
      servs.enable = lib.mkDefault true;
      progs.enable = lib.mkDefault true;
      user.enable = lib.mkDefault true;
    };

    home.enable = lib.mkDefault true;

  };
}
