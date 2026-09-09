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
  services.keyd = {
    enable = true;

    keyboards.default = {
      ids = [ "*" ];

      settings = {
        main = {
          capslock = "esc";
          esc = "capslock";
        };
      };
    };
  };

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
    ] ++ [
      inputs.freesmlauncher.packages.x86_64-linux.freesmlauncher
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
    wl-clipboard
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  networking.hostName = "Rhea";
  networking.networkmanager.enable = true;
  networking.modemmanager.enable = true;
  time.timeZone = "Asia/Colombo";

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
  };

  services.tuned.enable = true;

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
