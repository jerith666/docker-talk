let
  sources = import ./nix/sources.nix { };
  nixpkgs = import sources.nixpkgs { };

  message-of-the-day = ./message-of-the-day.txt;

in

nixpkgs.dockerTools.buildLayeredImage {
  name = "static-netcat-demo";
  config = {
    Entrypoint = [
      "${nixpkgs.pkgsStatic.socat}/bin/socat"
      "TCP-LISTEN:1234"
      "OPEN:${message-of-the-day}"
    ];
  };
}
