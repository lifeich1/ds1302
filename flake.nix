{
  description = "Lifeich1 forked ds1302 driver program";

  inputs.utils.url = "github:numtide/flake-utils";

  outputs =
    {
      self,
      nixpkgs,
      utils,
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        deps = with pkgs; [ wiringpi ];
      in
      {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "ds1302";
          version = "0.1.0";

          src = ./.;

          nativeBuildInputs = with pkgs; [ cmake ];

          buildInputs = deps;

          cmakeFlags = [ ];

          meta = with pkgs.lib; {
            homepage = "https://github.com/lifeich1/ds1302/tree/master";
            description = "ds1302 driver program";
            licencse = licenses.lgpl3Plus;
            platforms = [
              "aarch64-linux"
              "x86_64-linux"
              "i686-linux"
            ];
          };
        };

        devShells.default = pkgs.mkShell rec {
          buildInputs =
            with pkgs;
            [
              just
              stdenv.cc.cc
              cmake
            ]
            ++ deps;

          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;

          shellHook = ''
            exec $SHELL
          '';
        };
      }
    )
    // {
      overlays.default = self: pkgs: { ds1302 = self.packages."${pkgs.system}".default; };
    };
}
