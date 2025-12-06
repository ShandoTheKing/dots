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
    ./keyd.nix
    ./gui/mangowc.nix
  ];
}
