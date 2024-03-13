# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  user,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../common/configuration.nix
    ../../modules/nixos/gnome.nix
    ../../modules/nixos/laptop.nix
    #      <home-manager/nixos>
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernel.sysctl = {"vm.swappiness" = 10;};

  boot.initrd.luks.devices."luks-16c3483f-1fd2-481e-a6ad-90ed6f4d1fa3".device = "/dev/disk/by-uuid/16c3483f-1fd2-481e-a6ad-90ed6f4d1fa3";
  networking.hostName = "bumblebee"; # FIXME Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

}
