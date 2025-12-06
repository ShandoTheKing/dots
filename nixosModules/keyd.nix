{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.shando.keyd;
in
{
  options.shando.keyd = {
    enable = lib.mkEnableOption ''
      My keyboard settings using keyd.
    '';
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.keyd ];

    services.keyd = {
      enable = true;
      keyboards.default = {
        ids = [ "k:0001:0001:70533846"];
        settings = {
          main = {
            "capslock" = "esc";
            "esc" = "capslock";
            "a+s" = "leftcontrol";
            "h+j" = "leftcontrol";
            "s+d" = "leftshift";
            "j+k" = "leftshift";
            "d+f" = "leftalt";
            "k+l" = "leftalt";
          };
          globals = {
            "overload_tap_timeout" = 200;
            "chord_timeout" = 100;
          };
        };
      };
    };
  };
}
