{
  pkgs,
  inputs,
  ...
}: let
  image = ../wallpaper.png;
in {
  imports = [inputs.stylix.nixosModules.stylix];

  stylix = {
    enable = true;
    fonts = {
      sizes = {
        terminal = 11;
        applications = 11;
      };
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
    };
    image = image;
    polarity = "dark";
    opacity = {
      terminal = 0.9;
      popups = 0.85;
    };
  };
}
