{
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf config.base.servs.enable {
    services = {
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
      postgresql = {
        enable = true;
        ensureDatabases = ["icarusdb"];
        authentication = pkgs.lib.mkOverride 10 ''
          #type database  DBuser  auth-method
          local all       all     trust
        '';
      };
    };
  };
}
