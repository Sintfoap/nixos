{
pkgs,
lib,
inputs,
...
}:
let
  glfwww = inputs.wonderwall.packages.${pkgs.system}.glfw;
in 
  {
  imports = [
    ./dunst.nix
    ./term.nix
    ./rofi.nix
    ./fish.nix
  ];
  home.packages = map (a: pkgs.callPackage a {}) (lib.filesystem.listFilesRecursive ./scripts);
  home.file.".local/lib64/libglfw.so".source = "${glfwww}/lib/libglfw.so";

}
