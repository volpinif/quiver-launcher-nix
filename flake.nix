{
  description = "Quiver Launcher";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" ];

      forAllSystems = nixpkgs.lib.genAttrs systems;

      mkPackage = system:
        nixpkgs.legacyPackages.${system}.callPackage ./default.nix {};
    in
    {
      packages = forAllSystems (system: {
        quiver-launcher = mkPackage system;
        default = mkPackage system;
      });

      overlays.default = final: prev: {
        quiver-launcher = prev.callPackage ./default.nix {};
      };
    };
}

