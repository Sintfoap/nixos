{pkgs, ...}:
pkgs.writeShellScriptBin "chron" ''

  s=""
  if [ $# -eq 0 ]; then
    s="$(date '+%H:%M:%S:%1N')"
  else
    s="$1"
  fi


  IFS=":" read -ra parts <<< "$s"

  hour=''${parts[0]#0}
  mins=''${parts[1]#0}
  seconds=''${parts[2]#0}
  ms=''${parts[3]#0}
  chrons=$((hour * 3600 * 10 + mins * 60 * 10 + seconds * 10 + ms))
  chronz=''$(echo "($chrons) / 8.64" | bc -l)
  out=''$(printf "%05.0f" "$chronz")
  echo ''${out:0:2}.''${out:2:1} ''${out:3:3}
''
