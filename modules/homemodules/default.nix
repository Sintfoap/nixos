{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./dunst.nix
    ./term.nix
    ./shell.nix
    ./rofi.nix
  ];

  home.packages = map (a: pkgs.callPackage a {}) (lib.filesystem.listFilesRecursive ./scripts);
}
