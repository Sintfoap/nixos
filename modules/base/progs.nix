{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  config = lib.mkIf config.base.progs.enable {
    virtualisation.docker.enable = true;
    programs = {
      nix-ld = {
        enable = true;
        libraries = with pkgs; [glib];
      };
      hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      };
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
      };
    };
  };
}
