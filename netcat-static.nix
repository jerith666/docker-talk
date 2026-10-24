let
  sources = import ./nix/sources.nix { };
  nixpkgs = import sources.nixpkgs { };

in

nixpkgs.pkgsStatic.netcat
