{ inputs }:
let
  outputs = inputs.self.outputs;
  lib = inputs.lib;
in
rec {
  # Function that accepts a folder path and a list of exceptions, as a list of file names, in order to return a list of all folders and .nix files present
  allNixFilesFoldersExcept =
    folderPath: exceptionList:
    lib.pipe (builtins.readDir folderPath) [
      builtins.attrValues (
        builtins.mapAttrs (name: type:
          if ((type == "regular"
             && lib.hasSuffix ".nix" name)
             || (type == "directory"))
          then "${folderPath}/${name}"
          else null
        )
      )
      (x: if lib.any (a: lib.elem a exceptionList) x
  then null
  else x)
      lib.filter (y: y != null)
    ];

  mkNixosConfig =
    host:
    inputs.nixpkgs.lib.nixosSystem {
      pkgs = import inputs.nixpkgs {
        system = host.system;
        allowUnfree = true;
      };
      modules = [
        ({ config, lib, pkgs, ... }: {
          _module.args.myLib = outputs.myLib;
        })
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
        ({ config, lib, pkgs, ... }: {
          _module.args.myLib = outputs.myLib;
        })
        host.pathToConfig
        outputs.nixosModules.default
      ];
    };
}
