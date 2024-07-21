{
  description = "Flake for moltengamepad";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.11";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
      ];
    };
    moltengamepadctl = pkgs.stdenv.mkDerivation {
      name = "moltengamepadctl";
      src = ./.;

      hardeningDisable = ["fortify"];

      installPhase = ''
        mkdir -p $out/bin
        cp moltengamepadctl $out/bin
      '';

      meta = with pkgs.lib; {
        homepage = "https://github.com/jgeumlek/MoltenGamepadCtl";
        description = "Reference MoltenGamepad client";
        license = licenses.mit;
        maintainers = [maintainers.ebzzry];
        platforms = platforms.linux;
      };
    };
  in {
    packages.x86_64-linux.default = moltengamepadctl;
  };
}
