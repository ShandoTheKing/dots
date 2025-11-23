# COpied directly from mangowc repo on 2025.11.23
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.shando.mangowc;
in
{
  options = {
    shando.mangowc = {
      enable = lib.mkEnableOption "mango, a wayland compositor based on dwl";
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.mangowc;
        description = "The mango package to use";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];

    xdg.portal = {
      enable = lib.mkDefault true;

      wlr.enable = lib.mkDefault true;

      configPackages = [ cfg.package ];
    };

    security.polkit.enable = lib.mkDefault true;

    programs.xwayland.enable = lib.mkDefault true;

    services = {
      displayManager.sessionPackages = [
        (cfg.package.overrideAttrs (_: {
          passthru.providedSessions = [ "mango" ];
        }))
      ];

      graphical-desktop.enable = lib.mkDefault true;
    };
  };
}
