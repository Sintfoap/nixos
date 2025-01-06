{
  inputs,
  pkgs,
  ...
}: {
  config = {
    environment.systemPackages = with pkgs; [
      inputs.nix-alien.packages.${pkgs.system}.nix-alien
      inputs.fix-python.packages.${pkgs.system}.default
      inputs.alejandra.defaultPackage.${pkgs.system}
      inputs.orb.packages.${pkgs.system}.default
      networkmanagerapplet
      nix-output-monitor
      swaylock-effects
      docker-compose
      signal-desktop
      brightnessctl
      libqalculate
      arduino-ide
      arduino-cli
      protonup-ng
      ytmdesktop
      pulsemixer
      obs-studio
      steam-run
      libnotify
      python311
      fastfetch
      html-tidy
      nodejs_22
      quickemu
      r2modman
      onedrive
      autoconf
      minikube
      typstfmt
      libclang
      vesktop
      nyancat
      todoist
      openssh
      killall
      openvpn
      ripgrep
      conjure
      poetry
      pipenv
      choose
      awscli
      typst
      dpkg
      gdal
      qgis
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

      # Wayland
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
  };
}
