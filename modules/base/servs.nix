{
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf config.base.servs.enable {
    services = {
      displayManager.ly.enable = true;
      blueman.enable = true;
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        jack.enable = true;
        pulse.enable = true;
        wireplumber.enable = true;
      };
      xserver = {
        videoDrivers = ["nvidia"];
        xkb = {
          layout = "us";
          variant = "";
          options = "caps:escape";
        };
      };
    };
  };
}
