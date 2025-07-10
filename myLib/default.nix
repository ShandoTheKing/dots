{ inputs }:
let
  outputs = inputs.self.outputs;
  lib = inputs.lib;
in
rec {
  mkNixosConfig =
    host:
    inputs.nixpkgs.lib.nixosSystem {
      pkgs = import inputs.nixpkgs {
        system = host.system;
        allowUnfree = true;
      };
      modules = [
        host.pathToConfig
        outputs.nixosModules.default
      ] ++ host.extraModules;
    };
  mkNixOnDroidConfig = 
    host:
    inputs.nix-on-droid.lib.nixOnDroidConfiguration {
       pkgs = import inputs.nixpkgs { 
	 system = host.system;
	 allowUnfree = true; 
	 overlays = [ inputs.nix-on-droid.overlays.default ];
       };
       modules = [
         host.pathToConfig
	 outputs.nixosModules.default
       ];
    };
}
