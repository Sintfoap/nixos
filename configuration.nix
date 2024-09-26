{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    ./muse.nix
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "archemides";

  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";
  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    xserver = {
      layout = "us";
      xkbVariant = "";
      xkb.options = "caps:escape";
    };
  };

  users.users.ryanm = {
    isNormalUser = true;
    description = "Ryan Moffitt";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.fish;
  };

  home-manager = {
    users.ryanm = import ./home.nix;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  nix = {
    settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  environment.shellAliases = {
    nv = "nvim";
    cat = "bat";
    ls = "eza --icons --color";
    zip = "ouch";
  };

  environment.systemPackages = with pkgs; [
    inputs.orb.packages.${pkgs.system}.default
    inputs.fix-python.packages.${pkgs.system}.default
    inputs.alejandra.defaultPackage.${pkgs.system}
    nix-output-monitor
    signal-desktop
    protonup-ng
    fastfetch
    killall
    openvpn
    ripgrep
    vesktop
    python3
    choose
    htop
    ouch
    tldr
    bat
    feh
    nvd
    bc
    fd
    jq
    sd

    # Wayland - We're wQAy nix-output-monitor
    cliphist
    grim
    hyprpicker
    hyprshot
    slurp
    swappy
    sway-contrib.grimshot
    swww
    wl-clip-persist
    wl-clipboard
  ];

  programs = {
    fish.enable = true;
    nh = {
      enable = true;
      clean.enable = true;
      flake = "/home/ryanm/nixos";
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

  system.stateVersion = "24.05";
}
