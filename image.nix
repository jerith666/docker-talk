let
  sources = import ./nix/sources.nix { };
  nixpkgs = import sources.nixpkgs { };

  message-of-the-day = ./message-of-the-day.txt;

in

nixpkgs.dockerTools.buildLayeredImage {
  name = "static-netcat-demo";
  config = {
    Entrypoint = [
      "${nixpkgs.pkgsStatic.bash}/bin/sh"
      "-c"
      "${nixpkgs.pkgsStatic.netcat}/bin/nc -N -l 1234 < ${message-of-the-day}"
    ];
  };
}
