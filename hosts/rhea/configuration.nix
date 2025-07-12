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
    cozette
    alsa-utils
    alsa-tools
    bibata-cursors
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
  console = {
    enable = true;
    useXkbConfig = true;
    earlySetup = true;
    font = "${pkgs.cozette}/share/fonts/psf/cozette_hidpi.psf";
    packages = with pkgs; [ cozette ];
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

  nixpkgs.overlays = [
    (final: prev: {
      cozette = prev.cozette.overrideAttrs (
        finalAttrs: previousAttrs: {
          installPhase = ''
            runHook preInstall

            install -Dm644 *.ttf -t $out/share/fonts/truetype
            install -Dm644 *.otf -t $out/share/fonts/opentype
            install -Dm644 *.bdf -t $out/share/fonts/misc
            install -Dm644 *.otb -t $out/share/fonts/misc
            install -Dm644 *.woff -t $out/share/fonts/woff
            install -Dm644 *.woff2 -t $out/share/fonts/woff2
            install -Dm644 *.psf -t $out/share/fonts/psf

            runHook postInstall
          '';
        }
      );
    })
  ];

  system.stateVersion = "24.05"; # Do not change bruh

}
