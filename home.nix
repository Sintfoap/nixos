{pkgs, ...}: {
  home.stateVersion = "24.05";
  programs = {
    kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = "0";
        enable_audio_bell = false;
      };
    };
    foot = {
      enable = true;
    };
    fish = {
      enable = true;
      shellInit = ''
             function fish_command_not_found
        echo skill issue: $argv[1]
             end
             set -g fish_greeting ""
             ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      '';
    };
    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
    };
    git = {
      enable = true;
      userName = "Rmoffitt";
      userEmail = "rmoff938@students.bju.edu";
    };
    waybar = {
      enable = true;
      settings = [
        {
          height = 30;
          spacing = 6;
          tray.spacing = 10;
          layer = "top";
          position = "top";
          modules-center = [];
          modules-left = ["hyprland/workspaces"];
          modules-right = ["tray" "pulseaudio" "network" "cpu" "memory" "temperature" "disk" "backlight" "battery" "clock#c2" "clock" "custom/mt"];
          "hyprland/workspaces" = {
            format = "{icon}";
          };
          battery = {
            format = "{capacity}% {icon}";
            format-charging = "{capacity}% ";
            format-icons = ["" "" "" "" ""];
            format-plugged = "{capacity}% ";
            states = {
              critical = 7;
              warning = 15;
            };
          };
          clock = {
            interval = 1;
            format = "{:%H:%M:%S}";
          };
          "clock#c2".format = "{:%m-%d}";
          cpu = {
            format = "{usage}% ";
            tooltip = false;
          };
          memory.format = "{}% ";
          disk.format = "{percentage_used}% ⬤";
          network = {
            interval = 1;
            tooltip-format = "{ifname}: {ipaddr}/{cidr} |  ^ {bandwidthUpBits}, v {bandwidthDownBits} | {essid}";
            format-disconnected = "⚠";
            format-ethernet = "{signalStrength} ";
            format-wifi = "{signalStrength} ";
            format-linked = "{ifname} (No IP)";
            on-click = "nm-connection-editor";
          };
          pulseaudio = {
            format = "{volume}% {icon} {format_source}";
            format-bluetooth = "{volume}% {icon}  {format_source}";
            format-bluetooth-muted = " {icon}  {format_source}";
            format-icons = {
              car = "";
              default = ["" "" ""];
              handsfree = "";
              headphones = "";
              headset = "";
              phone = "";
              portable = "";
            };
            format-muted = " {format_source}";
            format-source = "{volume}% ";
            format-source-muted = "";
            on-click = "pavucontrol";
          };
          temperature = {
            critical-threshold = 80;
            format = "{temperatureC}°C {icon}";
            format-icons = ["" "" ""];
          };
        }
      ];
    };

    chromium = {
      enable = true;
      package = pkgs.brave;
      commandLineArgs = [
        "--enable-features=UseOzonePlatform "
        "--ozone-platform=wayland"
        "--password-store=basic"
      ];
      extensions = [
        "eimadpbcbfnmbkopoojfekhnkhdbieeh" # dark reader
        "gfbliohnnapiefjpjlpjnehglfpaknnc" # surfingkeys
        "nngceckbapebfimnlniiiahkandclblb" # bitwarden
	"pnlccmojcmeohlpggmfnbbiapkmbliob" # roboform
      ];
    };
    zoxide.enable = true;
  };
  home.packages = with pkgs; [
    fishPlugins.colored-man-pages
    fishPlugins.autopair
    fishPlugins.puffer
    fishPlugins.tide
    fishPlugins.done

    eza
    fzf

    (pkgs.callPackage ./startup.nix {})
  ];

  home.file = {
    ".config/hypr/hyprland.conf".text = ''
      source = ~/nixos/hyprland.conf
    '';
  };
}
