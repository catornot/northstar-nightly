{
  lib,
  pkgs,
  mods,
  version,
}:
let
in
pkgs.stdenv.mkDerivation (finalAttr: {
  pname = "NorthstarMods";
  inherit version;

  src = ../.;

  noUnpack = true;
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out

    cp -r ${mods}/* $out
  '';

  meta = {
    description = finalAttr.pname;
    homepage = "https://northstar.tf/";
    license = lib.licenses.mit;
  };
})
