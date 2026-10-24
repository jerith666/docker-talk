let
  sources = import ./nix/sources.nix { };
  nixpkgs = import sources.nixpkgs { };

in

nixpkgs.dockerTools.buildLayeredImage {
  name = "static-netcat-demo";
  config = {
    Entrypoint = [
      "${nixpkgs.pkgsStatic.netcat}/bin/nc"
      "-l"
      "1234"
    ];
  };
}
