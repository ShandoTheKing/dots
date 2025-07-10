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

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.loader.grub.extraEntries = ''
        menuentry 'Windows Boot Manager (on /dev/nvme0n1p1)' --class windows --class os $menuentry_id_option 'osprober-efi-1502-E6F5' {
    	insmod part_gpt
    	insmod fat
    	search --no-floppy --fs-uuid --set=root 1502-E6F5
    	chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        }
        menuentry 'Fedora Linux 41 (Workstation Edition) (on /dev/nvme0n1p3)' --class fedora --class gnu-linux --class gnu --class os $menuentry_id_option 'osprober-gnulinux-simple-c5da5d36-2c15-41f8-9684-562dab8f0890' {
    	insmod part_gpt
    	insmod ext2
    	search --no-floppy --fs-uuid --set=root c5da5d36-2c15-41f8-9684-562dab8f0890
    	linux /boot/vmlinuz-6.8.5-301.fc40.x86_64 root=/dev/nvme0n1p3
    	initrd /boot/initramfs-6.8.5-301.fc40.x86_64.img
        }
        submenu 'Advanced options for Fedora Linux 41 (Workstation Edition) (on /dev/nvme0n1p3)' $menuentry_id_option 'osprober-gnulinux-advanced-c5da5d36-2c15-41f8-9684-562dab8f0890' {
    	menuentry 'Fedora Linux 41 (Workstation Edition) (on /dev/nvme0n1p3)' --class gnu-linux --class gnu --class os $menuentry_id_option 'osprober-gnulinux-/boot/vmlinuz-6.8.5-301.fc40.x86_64--c5da5d36-2c15-41f8-9684-562dab8f0890' {
    		insmod part_gpt
    		insmod ext2
    		search --no-floppy --fs-uuid --set=root c5da5d36-2c15-41f8-9684-562dab8f0890
    		linux /boot/vmlinuz-6.8.5-301.fc40.x86_64 root=/dev/nvme0n1p3
    		initrd /boot/initramfs-6.8.5-301.fc40.x86_64.img
    	}
        }   
  '';

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
