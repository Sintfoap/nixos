{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    location = "center";
    terminal = "cool-retro-term";
    plugins = with pkgs; [rofi-emoji-wayland (rofi-calc.override {rofi-unwrapped = pkgs.rofi-wayland-unwrapped;})];
    extraConfig = {
      drun-display-format = "{icon} {name}";
      show-icons = true;
      hide-scrollbar = true;
      display-drun = " 󰀘 =>  ";
      display-calc = " ⅀ =>  ";
      display-emoji = " 🫠 =>  ";
    };
  };
}
