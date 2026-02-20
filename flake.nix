{
  description = "Northstar Nightly Builds";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    mods = {
      url = "github:R2Northstar/NorthstarMods";
      flake = false;
    };
    northstar-repo = {
      url = "github:R2Northstar/Northstar";
      flake = false;
    };
    launcher.url = "git+https://github.com/R2Northstar/NorthstarLauncher.git?submodules=1";

    discordrpc.url = "github:R2Northstar/NorthstarDiscordRPC";
  };
  outputs =
    {
      self,
      nixpkgs,
      utils,
      mods,
      launcher,
      discordrpc,
      northstar-repo,
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        version = self.shortRev or self.dirtyShortRev or "unknown";
      in
      {
        formatter = pkgs.nixfmt-tree;

        packages =
          {
            default = self.packages.${system}.northstar;
          }
          // import ./pkgs {
            inherit
              self
              pkgs
              mods
              launcher
              discordrpc
              northstar-repo
              system
              version
              ;
          };
      }
    );
}
