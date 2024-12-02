{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    ./muse.nix
  ];
  hardware.nvidia.prime = {
    # Make sure to use the correct Bus ID values for your system!
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:0:1:0";
    # amdgpuBusId = "PCI:54:0:0"; For AMD GPU
  };
  hardware.pulseaudio.enable = false;
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    networkmanager.enable = true;
    hostName = "archemides";
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  time.timeZone = "America/New_York";

  virtualisation.docker.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";
  services = {
    blueman.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    xserver = {
      videoDrivers = ["nvidia"];
      xkb = {
        layout = "us";
        variant = "";
        options = "caps:escape";
      };
    };
    postgresql = {
      enable = true;
      ensureDatabases = ["icarusdb"];
      authentication = pkgs.lib.mkOverride 10 ''
        #type database  DBuser  auth-method
        local all       all     trust
      '';
    };
  };
  # Enable OpenGL
  hardware.opengl = {
    enable = true;
  };

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  users = {
    users.ryanm = {
      isNormalUser = true;
      description = "Ryan Moffitt";
      extraGroups = ["networkmanager" "wheel" "video" "audio" "libvirtd" "docker" "bluetooth"];
      shell = pkgs.fish;
    };
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
    nixvim = "/home/ryanm/nixvim/result/bin/nvim";
    cat = "bat";
    ls = "eza --icons --color";
    zip = "ouch";
    h = "Hyprland";
  };

  environment.systemPackages = with pkgs; [
    inputs.nix-alien.packages.${pkgs.system}.nix-alien
    inputs.fix-python.packages.${pkgs.system}.default
    inputs.alejandra.defaultPackage.${pkgs.system}
    inputs.orb.packages.${pkgs.system}.default
    (pkgs.callPackage ./chron.nix {})
    networkmanagerapplet
    nix-output-monitor
    libsForQt5.okular
    swaylock-effects
    signal-desktop
    docker-compose
    brightnessctl
    libqalculate
    texliveFull
    protonup-ng
    presenterm
    pulsemixer
    obs-studio
    kubernetes
    python311
    fastfetch
    steam-run
    libnotify
    html-tidy
    nodejs_22
    r2modman
    autoconf
    minikube
    quickemu
    typstfmt
    dolphin
    openssh
    nyancat
    kompose
    killall
    kubectl
    openvpn
    ripgrep
    vesktop
    conjure	
    sticky
    awscli
    poetry
    pipenv
    choose
    typst
    qgis
    gdal
    dpkg
    wine
    htop
    ouch
    tldr
    pipx
    gcc
    bat
    feh
    nvd
    bc
    fd
    jq
    sd

    # Wayland - We're wQAy nix-output-monitor
    sway-contrib.grimshot
    wl-clip-persist
    wl-clipboard
    hyprpicker
    hyprshot
    cliphist
    swappy
    slurp
    grim
    swww
  ];

  programs = {
    fish.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [glib];
    };
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
