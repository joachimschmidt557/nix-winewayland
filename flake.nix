{

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "i686-linux" ] (system:

      let pkgs = nixpkgs.legacyPackages.${system}; in
      rec {
        packages = flake-utils.lib.flattenTree
          (
            let
              recurseIntoAttrs = pkgs.recurseIntoAttrs;
              winePackagesFor = wineBuild: (import ./wine-packages.nix {
                inherit wineBuild;

                stdenv = pkgs.stdenv;
                callPackage = pkgs.callPackage;
              });
            in
            {
              wine32 = recurseIntoAttrs (winePackagesFor "wine32");

              wine64 = recurseIntoAttrs (winePackagesFor "wine64");

              wineWow = recurseIntoAttrs (winePackagesFor "wineWow");
            }
          );

        defaultPackage = packages."wine32/full";
      });

}
