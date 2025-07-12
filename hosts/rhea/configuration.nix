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
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
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
    alsa-utils
    alsa-tools
    bibata-cursors
    tamsyn
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  networking.hostName = "Rhea";
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Colombo";

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
  programs.zsh.enable = true;

  system.activationScripts.nvim-config = {
    text = ''
      mkdir -p /home/shando/.config
      ln -sfn /home/shando/dots/nvim /home/shando/.config/nvim
      chown -R shando:users /home/shando/.config/nvim
    '';
  };

  system.stateVersion = "24.05"; # Do not change bruh

}
