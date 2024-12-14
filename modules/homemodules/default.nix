{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./dunst.nix
    ./term.nix
    ./rofi.nix
    ./fish.nix
  ];

  home.packages = map (a: pkgs.callPackage a {}) (lib.filesystem.listFilesRecursive ./scripts);
}
