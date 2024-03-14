# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-1ba7599a-59b8-429c-964f-36a755b5a75d".device = "/dev/disk/by-uuid/1ba7599a-59b8-429c-964f-36a755b5a75d";
  networking.hostName = "hornet"; # Define your hostname.
}
