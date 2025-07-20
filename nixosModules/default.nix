{ inputs }:
let
  myLib = inputs.self.outputs.myLib;
in {
  import  = myLib.allNixFilesFoldersExcept "./" "default.nix";
}
