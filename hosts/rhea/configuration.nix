{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  shando.baseCli.enable = true;
  shando.mangowc.enable = true;
  shando.keyd.enable = true;

  users.users.shando = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    packages = with pkgs; [
      firefox
      kitty
    ];
  };

  environment.systemPackages = with pkgs; [
    alsa-utils
    alsa-tools
    bibata-cursors
    tamsyn
    onlyoffice-desktopeditors
    onagre
    usbutils
    pciutils
    bluetui
    zathura
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  networking.hostName = "Rhea";
  networking.networkmanager.enable = true;
  networking.modemmanager.enable = true;
  time.timeZone = "Asia/Colombo";

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "doom";
      doom_fire_height = 3;
      doom_fire_spread = 1;
      doom_bottom_color = "0x0062E8C8";
      doom_middle_color = "0x0054E287";
      doom_top_color = "0x0000C5A7";
      hide_version_string = true;
      vi_mode = true;
      battery_id = "BAT0";
    };
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  fonts.packages = with pkgs; [ spleen ];
  console = {
    enable = true;
    useXkbConfig = true;
    earlySetup = true;
    font = "${pkgs.tamsyn}/share/consolefonts/Tamsyn10x20r.psf.gz";
    packages = with pkgs; [ tamsyn ];
  };

  # Enable the X11 windowing system.
  services.printing.enable = true;
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true; # Otherwise lightdm is installed for no reason
    xkb.layout = "us";
    xkb.options = "caps:escape";
  };

  programs.river.enable = true;
  services.libinput.enable = true;
  xdg.portal.wlr.enable = true;

  system.stateVersion = "24.05"; # Do not change bruh

}
