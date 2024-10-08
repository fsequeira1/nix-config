# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../common/configuration.nix
    ../../modules/nixos/gnome.nix
    ../../modules/nixos/laptop.nix
    ../../modules/nixos/docker.nix
    ../../modules/nixos/security.nix
    #      <home-manager/nixos>
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernel.sysctl = {"vm.swappiness" = 10;};

  networking.hostName = "bumblebee"; # FIXME Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  
  system.autoUpgrade = {
    enable = true;
    dates = "daily";
    #allowReboot = true;
    #flake = self.outPath;
    flake = "github:fsequeira1/nix-config#bumblebee";
    flags = [
      "--update-input"
      "nixpkgs"
      "--no-write-lock-file"
      "-L" # print build logs
    ];
  };
}
