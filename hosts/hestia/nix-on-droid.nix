{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Simply install just the packages
  environment = {
    packages = with pkgs; [
      neovim
      procps
      killall
      diffutils
      findutils
      utillinux
      tzdata
      hostname
      man
      gnugrep
      gnupg
      gnused
      gnutar
      bzip2
      gzip
      xz
      zip
      unzip
      cozette
      cascadia-code
    ];
    motd = ''
      Waddup bitch 
    '';
  };

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";
  android-integration = {
    am.enable = true;
    termux-open.enable = true;
    termux-open-url.enable = true;
    termux-reload-settings.enable = true;
    termux-setup-storage.enable = true;
    termux-wake-lock.enable = true;
    termux-wake-unlock.enable = true;
    xdg-open.enable = true;
  };

  # Read the changelog before changing this value
  system.stateVersion = "24.05";

  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Set your time zone
  time.timeZone = "Asia/Colombo";

  terminal.font = "${pkgs.cascadia-code}/share/fonts/truetype/CascadiaMonoNF-Regular.ttf";
}
