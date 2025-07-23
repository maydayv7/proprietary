{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    inputs:
    with inputs;
    let
      inherit (nixpkgs) lib;
    in
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        call = path: pkgs.callPackage path { inherit lib pkgs; };
      in
      {
        packages = {
          fonts = call ./fonts;
          cursors = call ./cursors;
        };
      }
    )
    // {
      files =
        let
          call =
            path: ext:
            (lib.filterAttrs (_: val: !(lib.hasSuffix ".nix" val)) (
              lib.mapAttrs' (name: _: lib.nameValuePair (lib.removeSuffix ext name) "${path}/${name}") (
                builtins.readDir path
              )
            ))
            // {
              inherit path;
            };
        in
        {
          fonts = call ./fonts ""; # Proprietary Fonts
          wallpapers = call ./wallpapers ".jpg"; # Beautiful Wallpapers
        };
    };
}
