{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
  }: let
    inherit (nixpkgs) lib;
  in
    utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.fonts = pkgs.callPackage ./fonts {inherit lib pkgs;};
    })
    // {
      files = {
        discord = ./discord;
        wallpapers = with lib; let
          path = ./wallpapers;
        in
          (lib.mapAttrs' (name: _: lib.nameValuePair (lib.removeSuffix ".jpg" name) "${path}/${name}")
            (builtins.readDir path))
          // {inherit path;};
      };
    };
}
