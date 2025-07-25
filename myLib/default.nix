{ inputs }:
let
  outputs = inputs.self.outputs;
  lib = inputs.nixpkgs.lib;
in
rec {
<<<<<<< Updated upstream
=======
  # Recursively List all files ending with ".nix" AND does not contain any "_" in its file path
  listAllNixFilesRecursive =
    folderPath: currentFile:
    lib.pipe (lib.filesystem.listFilesRecursive folderPath) [
      (lib.filter (n: lib.strings.hasSuffix ".nix" n))
      (lib.filter (n: !lib.strings.hasInfix "_" n))
      (lib.filter (path: path != currentFile))
    ];

>>>>>>> Stashed changes
  mkNixosConfig =
    host:
    inputs.nixpkgs.lib.nixosSystem {
      pkgs = import inputs.nixpkgs {
        system = host.system;
        allowUnfree = true;
      };
      modules = [
<<<<<<< Updated upstream
=======
        ./default.nix
>>>>>>> Stashed changes
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
