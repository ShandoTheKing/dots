{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.shando.baseCli;
in
{
  options.shando.baseCli = {
    enable = lib.mkEnableOption ''
      My CLI env that should be on all systems
    '';
  };

  config = lib.mkIf cfg.enable {

    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;

    environment.etc."zshenv".text = ''
      export ZDOTDIR="$HOME/.config/zsh"
    '';

    environment.systemPackages = with pkgs; [
      nil
      gcc
      gnumake
      unzip
      curl
      nodejs
      python3
      luarocks
      neovim
      wget
      git
      htop
      arduino-cli
      stow
    ];
  };
}
