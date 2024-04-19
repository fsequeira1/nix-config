# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../common/configuration.nix
    ../../modules/nixos/gnome.nix
    ../../modules/nixos/docker.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hornet"; # Define your hostname.

  programs.hyprland.enable = true;

  system.autoUpgrade = {
    enable = true;
    dates = "daily";
    allowReboot = true;
    #flake = self.outPath;
    flake = "github:fsequeira1/nix-config#hornet";
    flags = [
      "--update-input"
      "nixpkgs"
      "--no-write-lock-file"
      "-L" # print build logs
    ];
  };
}
