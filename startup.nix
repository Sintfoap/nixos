{pkgs,  ...}:
pkgs.writeShellScriptBin "Aracnea" ''
  nm-applet &
  discord &
  killall .waybar-wrapped
  waybar &
  swww-daemon &
  swww img ~/wallpaper.png

  wl-paste --type text --watch cliphist store
  wl-paste --type image --watch cliphist store
''

