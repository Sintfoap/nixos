{
  lib,
  pkgs,
  ...
}: {
  programs = {
    fish = {
      enable = true;
      shellInit = ''
        function fish_command_not_found
        echo skill issue: $argv[1]
        end

        set -g fish_greeting ""

        alias nv 'nvim'
        alias nixvim '/home/ryanm/nixvim/result/bin/nvim'
        alias cat 'bat'
        alias ls 'eza --icons --color'
        alias zip 'ouch'
        alias h 'Hyprland'
        alias kart '/home/ryanm/programs/opt/kart/kart'
        abbr -a staging "STAGING_BRANCH=(git branch --show-current)"
        abbr -a prod 'VS_RUN_PROD=1'
        abbr -a pt CID=\$DEV python -m pytest -vv --durations=5 --pdb
        abbr -a rpy rg --iglob='\'*.py'\'
	abbr -a ptry source "(string split ' ' (poetry env activate))[2]"

        ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      '';
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
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
  ];
}
# function pythonEnv --description 'start a nix-shell with the given python packages' --argument pythonVersion
# if set -q argv[2]
#   set argv $argv[2..-1]
#     end
#     for el in $argv
#       set ppkgs $ppkgs "python"$pythonVersion"Packages.$el"
# 	end
# 	nix-shell -p $ppkgs
# 	end

