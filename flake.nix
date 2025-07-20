{
  description = "Shando's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-wsl,
      home-manager,
      nix-on-droid,
      nixos-hardware,
      ...
    }@inputs:
    let
      myLib = import ./myLib { inherit inputs; };
    in
    {
      myLib = myLib; # Make myLib reusable outside flake.nix
      nixosConfigurations = with myLib; {
        Rhea = mkNixosConfig {
          system = "x86_64-linux";
          pathToConfig = ./hosts/rhea/configuration.nix;
          extraModules = [
            nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1
          ];
        };
        Ops = mkNixosConfig {
          system = "x86_64-linux";
          pathToConfig = ./hosts/ops/configuration.nix;
          extraModules = [
            nixos-wsl.nixosModules.wsl
          ];
        };
      };
      nixOnDroidConfigurations = with myLib; {
        Hestia = mkNixOnDroidConfig {
          system = "aarch64-linux";
          pathToConfig = ./hosts/hestia/nix-on-droid.nix;
        };
      };
      nixosModules.default = import ./nixosModules { inherit inputs; };
    };
}
