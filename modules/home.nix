{pkgs, ...}: let
  username = "ryanm";
  homeDirectory = "/home/${username}";
in {
  imports = [./homemodules];

  home = {
    inherit username homeDirectory;
    enableNixpkgsReleaseCheck = false;
    stateVersion = "23.11";
  };

  programs = {
    git = {
      enable = true;
      userName = "Sintfoap";
      userEmail = "rmoff938@students.bju.edu";
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
        "nngceckbapebfimnlniiiahkandclblb" # bitwarden
        "hfjbmagddngcpeloejdejnfgbamkjaeg" # vimium-c
        "pnlccmojcmeohlpggmfnbbiapkmbliob" # roboform
        "cndibmoanboadcifjkjbdpjgfedanolh" # canvas
      ];
    };
    firefox = {
      enable = true;
    };
  };
}
