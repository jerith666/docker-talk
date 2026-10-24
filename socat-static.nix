let
  sources = import ./nix/sources.nix { };
  nixpkgs = import sources.nixpkgs { };

  disallowed = with nixpkgs.pkgsStatic; [
      openssl openssl.bin openssl.dev openssl.etc
      ncurses ncurses.dev ncurses.man
      readline readline.dev
    ];

in

nixpkgs.pkgsStatic.socat.overrideAttrs (old: {
  nativeBuildInputs = (old.nativeBuildInputs or []) ++ [ nixpkgs.removeReferencesTo ];
  propagatedBuildInputs = [];
  postFixup = (old.postFixup or "") + (
    nixpkgs.lib.concatMapStrings
      (p: ''
            for b in socat1 filan procan; do
                remove-references-to -t ${p} $out/bin/$b
            done
          '')
      disallowed
  );
  disallowedReferences = disallowed;
})
