{pkgs ? import <nixpkgs> {}}: let 
  lib = pkgs.lib;
  in 
    pkgs.mkShellNoCC {
      packages = map(a: pkgs.callPackage a {}) (lib.filesystem.listFilesRecursive ./scripts);
    }
