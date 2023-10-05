{
  lib,
  pkgs,
  ...
}:
pkgs.stdenv.mkDerivation rec {
  pname = "fonts";
  version = "7";

  src = ../fonts;
  dontBuild = true;
  installPhase = "mkdir -p $out/share/fonts/ && cp -r . $out/share/fonts/";

  meta = with lib; {
    description = "Custom Proprietary Fonts";
    maintainers = ["maydayv7"];
  };
}
