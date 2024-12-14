{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-stable.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager"; # module to manage home config files
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    orb.url = "github:Sintfoap/nixvim";
    alejandra.url = "github:kamadorueda/alejandra/3.0.0"; # formatter
    fix-python.url = "github:GuillaumeDesforges/fix-python"; # script to fix python binaries
    nix-alien.url = "github:thiagokokada/nix-alien";
    stylix.url = "github:danth/stylix"; # module to style all apps and guis
  };
  outputs = inputs: let
    system = "x86_64-linux";
    inherit (inputs.nixpkgs) lib; # this is the same as `lib = inputs.nixpkgs.lib;`

    stable_overlay = final: _prev: {stable = import inputs.nix-stable {system = final.system;};};
    overlays = [stable_overlay]; # this lets us access stable packages by doing `pkgs.stable`

    pkgs = import inputs.nixpkgs {
      inherit system overlays; # same thing as `system = system; overlays = overlays;`
      config.allowUnfree = true; # allow proprietary software
    };
  in {
    nixosConfigurations = {
      archemides = lib.nixosSystem {
        specialArgs = {inherit pkgs inputs;};
        modules = [./configuration.nix];
      };
    };
  };
}
