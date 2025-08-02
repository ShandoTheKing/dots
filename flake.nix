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
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

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
      overlays = [
        inputs.neovim-nightly-overlay.overlays.default
      ];
    in
    {
      nixosConfigurations = with myLib; {
        Rhea = nixpkgs.lib.nixosSystem {
          pkgs = import inputs.nixpkgs {
            system = "x86_64-linux";
            allowUnfree = true;
          };
          modules = [
            ./hosts/rhea/configuration.nix
            ./nixosModules
            { nixpkgs.overlays = overlays; }
            nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1
          ];
        };
      };
      nixOnDroidConfigurations = {
        Hestia = nix-on-droid.lib.nixOnDroidConfiguration {
          pkgs = import inputs.nixpkgs {
            system = "aarch64-linux";
            allowUnfree = true;
            overlays = [ inputs.nix-on-droid.overlays.default ];
          };
          modules = [
            ./hosts/hestia/nix-on-droid.nix
            ./nixosModules
            { nixpkgs.overlays = overlays; }
          ];
        };
      };
    };
}
