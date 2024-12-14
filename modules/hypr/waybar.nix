{
  config,
  lib,
  ...
}: let
  # indexOf = list: item: let
  #   indexHelper = l: i:
  #     if l == []
  #     then -1
  #     else if builtins.elemAt l 0 == item
  #     then i
  #     else indexHelper (builtins.tail l) (i + 1); # Recurse with the next index and tail of the list
  # in
  # indexHelper list 0;
  # colors = [
  #   "#${config.stylix.base16Scheme.base09}"
  #   "#${config.stylix.base16Scheme.base0A}"
  #   "#${config.stylix.base16Scheme.base0B}"
  #   "#${config.stylix.base16Scheme.base0C}"
  # ];
  mods =
    if (config.networking.hostName == "labyrinth")
    then ["backlight" "battery" "tray" "pulseaudio" "network" "cpu" "memory" "temperature" "disk" "clock#c2" "clock" "custom/mt" "custom/ktv"]
    else ["tray" "pulseaudio" "network" "cpu" "memory" "temperature" "disk" "backlight" "battery" "clock#c2" "clock" "custom/mt" "custom/ktv"];
  # modulo' = a: b: a - b * builtins.div a b;
  # modulo = a: (modulo' a (builtins.length colors));
  # c = lib.attrsets.genAttrs mods (mod: (builtins.elemAt colors (modulo (indexOf mods mod))));
in {
  home-manager.users.ryanm.programs.waybar = lib.mkIf config.hypr.enable {
    enable = true;
    settings = [
      {
        height = 30;
        spacing = 6;
        tray = {
          spacing = 10;
          show-passive-items = true;
        };
        layer = "top";
        position = "top";
        modules-center = [];
        modules-left = ["hyprland/workspaces"];
        modules-right = mods;
        backlight = {
          format = "{percent}% {icon}";
          format-icons = ["" ""];
        };
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
        "custom/mt" = {
          interval = 1;
          exec = "chron";
          format = "{}";
        };
        "custom/ktv" = {
          interval = 1;
          exec = "ktv | choose -c 0:5";
          format = "{}";
        };
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
}
