{
  lib,
  pkgs,
  launcher,
  mods,
  discordrpc,
  northstar-repo,
  northstar-stubs,
  version,
}:
let
in
pkgs.stdenv.mkDerivation (finalAttr: {
  pname = "Northstar";
  inherit version;

  src = ../.;

  noUnpack = true;
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out
    mkdir -p $out/bin/x64_dedi
    mkdir -p $out/R2Northstar
    mkdir -p $out/R2Northstar/mods/
    mkdir -p $out/R2Northstar/plugins

    cp -r ${discordrpc}/bin/* $out/R2Northstar/plugins/
    cp -r ${mods}/* $out/R2Northstar/mods/
    cp -r ${launcher}/* $out/
    cp -r ${northstar-stubs}/bin/* $out/bin/x64_dedi

    cp -r ${northstar-repo}/release/LEGAL.txt $out/LEGAL.txt
    cp -r ${northstar-repo}/release/r2ds.bat $out/r2ds.bat
  '';

  meta = {
    description = finalAttr.pname;
    homepage = "https://northstar.tf/";
    license = lib.licenses.mit;
  };
})
