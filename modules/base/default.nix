{
  lib,
  config,
  ...
}: {
  imports = [
    ./servs.nix
    ./progs.nix
    ./user.nix
  ];

  options.base = {
    enable = lib.mkEnableOption "Enables base.nix";
    servs.enable = lib.mkEnableOption "Enables services";
    progs.enable = lib.mkEnableOption "Enables programs";
    user.enable = lib.mkEnableOption "Enables user";
  };

  config = lib.mkIf config.base.enable {
    networking.networkmanager.enable = true;

    time.timeZone = "America/New_York";
    i18n.defaultLocale = "en_US.UTF-8";

    nix = {
      settings = {
        substituters = ["https://hyprland.cachix.org"];
        trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
    };

    system = {
      stateVersion = "24.05"; # DO NOT CHANGE
      autoUpgrade.enable = true;
    };

    environment = {
      variables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
        BROWSER = "brave";
        TERMINAL = "foot";
      };
    };
  };
}
