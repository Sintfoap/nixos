{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [./waybar.nix];

  options.hypr.enable = lib.mkEnableOption "Enables Hyprland";

  config = lib.mkIf config.hypr.enable {
    programs.hyprland.enable = true;

    home-manager.users.ryanm.wayland.windowManager.hyprland = {
      enable = true;
      settings = lib.mkForce {
        monitor = [",preferred, auto, auto"];
        exec-once = [
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "vesktop & signal-desktop & cool-retro-term & nm-applet & brave & waybar & swww-daemon & bluetoothd & blueman-manager"
          "wl-paste --watch cliphist store"
          "swww img ~/wallpaper.png"
        ];

        input = {
          kb_layout = "us, us";
          kb_options = "caps:escape";

          follow_mouse = 1;

          touchpad.natural_scroll = true;

          sensitivity = 0;
          repeat_delay = 215;
          repeat_rate = 50;
        };

        general = {
          gaps_in = 5;
          gaps_out = 20;

          border_size = 1;

          "col.active_border" = "rgba(${config.stylix.base16Scheme.base04}ff) rgba(${config.stylix.base16Scheme.base0C}ff) 30deg";
          "col.inactive_border" = "rgba(${config.stylix.base16Scheme.base01}aa)";

          resize_on_border = false;
          layout = "dwindle";
        };

        decoration = {
          rounding = 0;

          blur = {
            enabled = true;
            size = 3;
            passes = 1;
          };
        };
        misc = {
          force_default_wallpaper = 0;
          disable_hyprland_logo = false;
        };

        animations = {
          enabled = true;

          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        gestures.workspace_swipe = false;

        windowrulev2 = [
          "workspace 1, initialTitle:^(.*cool-retro-term.*)$"
          "fullscreen, initialTitle:^(.*cool-retro-term.*)$"
          "workspace 1, title:^(.*firefox.*)$"
          "workspace 1, title:^(.*kitty.*)$"
          "workspace 2, title:^(.*Signal.*)$"
          "workspace 2, title:^(.*vesktop.*)$"
          "workspace 3, title:^(.*Brave.*)$"
        ];

        bind = [
          "SUPER + CONTROL, l, exec, swaylock --clock --indicator --fade-in 0.2 --indicator-image /home/ryanm/wallpaper.png --screenshots --effect-blur 7x5 --effect-vignette 0.5:0.5 --indicator-radius 100 --indicator-thickness 7 --key-hl-color 2e1409 --line-color 613e2e  --separator-color a49b9c --ring-color b5b9c2"
          ",xf86audiolowervolume, exec, pulsemixer --change-volume -5"
          ",xf86audioraisevolume, exec, pulsemixer --max-volume 150 --change-volume +5"
          ",xf86audiomute, exec, pulsemixer --toggle-mute"
          ",xf86monbrightnessup, exec, brightnessctl s 10%+"
          ",xf86monbrightnessdown, exec, brightnessctl s 10%-"
          "SUPER + SHIFT, b, exec, brave"
          "SUPER + SHIFT, v, exec, vesktop"
          "SUPER + SHIFT, d, exec, signal-desktop"
          "SUPER, RETURN, exec, cool-retro-term"
          "SUPER, B, exec, rofi -show drun"
          "SUPER, c, exec, rofi -show calc -modi calc -no-show-match -no-sort -qalc-binary qalc | wl-copy"
          "SUPER, v, exec, ${pkgs.stable.cliphist}/bin/cliphist list | rofi -dmenu | ${pkgs.stable.cliphist}/bin/cliphist decode | wl-copy"
          "SUPER, SPACE, togglefloating,"
          "SUPER, P, pseudo, # dwindle"
          "SUPER, t, togglesplit,"
          "SUPER + SHIFT, Q, killactive,"
          "SUPER, M, exit"
          "SUPER, R, exec, $menu"
          "SUPER, N, exec, sticky"
          ", print, exec, ${pkgs.hyprshot}/bin/hyprshot -m output --clipboard-only"
          "SHIFT, print, exec, ${pkgs.hyprshot}/bin/hyprshot -m window --clipboard-only"
          "SUPER SHIFT, s, exec, ${pkgs.hyprshot}/bin/hyprshot -m region --clipboard-only"
          "SUPER CONTROL, s, exec, wl-paste | ${pkgs.swappy}/bin/swappy -f -"
          "SUPER, f, fullscreen, 1"
          "SUPER SHIFT, f, fullscreen, 0"
          "SUPER, o, movecurrentworkspacetomonitor, +1"
          "SUPER, h, movefocus, l"
          "SUPER, l, movefocus, r"
          "SUPER, k, movefocus, u"
          "SUPER, j, movefocus, d"
          "SUPER SHIFT, j, movewindow, d"
          "SUPER SHIFT, k, movewindow, u"
          "SUPER SHIFT, h, movewindow, l"
          "SUPER SHIFT, l, movewindow, r"
          "SUPER SHIFT, t, togglesplit"
          "SUPER, 1, workspace, 1"
          "SUPER, 2, workspace, 2"
          "SUPER, 3, workspace, 3"
          "SUPER, 4, workspace, 4"
          "SUPER, 5, workspace, 5"
          "SUPER, 6, workspace, 6"
          "SUPER, 7, workspace, 7"
          "SUPER, 8, workspace, 8"
          "SUPER, 9, workspace, 9"
          "SUPER, 0, workspace, 10"
          "SUPER SHIFT, 1, movetoworkspace, 1"
          "SUPER SHIFT, 2, movetoworkspace, 2"
          "SUPER SHIFT, 3, movetoworkspace, 3"
          "SUPER SHIFT, 4, movetoworkspace, 4"
          "SUPER SHIFT, 5, movetoworkspace, 5"
          "SUPER SHIFT, 6, movetoworkspace, 6"
          "SUPER SHIFT, 7, movetoworkspace, 7"
          "SUPER SHIFT, 8, movetoworkspace, 8"
          "SUPER SHIFT, 9, movetoworkspace, 9"
          "SUPER SHIFT, 0, movetoworkspace, 10"
        ];
        bindm = [
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];
      };
    };
  };
}
