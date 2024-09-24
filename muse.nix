{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];
  stylix = {
    enable = true;
    fonts = {
      sizes = {
        terminal = 13;
      };
      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
        name = "JetBrainsMono Nerd Font Mono";
      };
    };
    image = /home/ryanm/wallpaper.png;
    polarity = "dark";
    opacity = {
      terminal = 0.9;
      popups = 0.85;
    };
  };
}
