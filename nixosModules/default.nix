{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./baseCli.nix
    ./gui/mangowc.nix
  ];
}
