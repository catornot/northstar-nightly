{
  self,
  pkgs,
  mods,
  launcher,
  discordrpc,
  northstar-repo,
  system,
  version,
  ...
}:
let
  getPackage = pkg: self.packages.${system}.${pkg};
  listToPackages =
    list:
    builtins.listToAttrs (
      map (name: {
        name = name;
        value = getPackage name;
      }) list
    );
in
{
  launcher = launcher.packages.${system}.default;
  mods = pkgs.callPackage ./mods { inherit mods version; };
  discordrpc = discordrpc.packages.${system}.default;
  northstar-stubs = pkgs.callPackage ./northstar-stubs {};
  northstar = pkgs.callPackage ./northstar (
    {
      inherit
        version
        northstar-repo
        ;
    }
    // listToPackages [
      "launcher"
      "mods"
      "discordrpc"
      "northstar-stubs"
    ]
  );
}
