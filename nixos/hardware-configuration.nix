# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "thunderbolt" "vmd" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
      kernelModules = [ ];
      luks.devices."luks-b876dadf-218b-4634-87f4-8f62d6235364".device = "/dev/disk/by-uuid/b876dadf-218b-4634-87f4-8f62d6235364";
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  fileSystems = {
    "/" =
      { device = "/dev/disk/by-uuid/4b16e873-66e5-46c0-a880-47b6f28a753a";
        fsType = "ext4";
      };

    "/boot" =
    { device = "/dev/disk/by-uuid/E81C-D230";
      fsType = "vfat";
    };

  };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/c2dfd031-442d-42fb-9f27-1d2a2a04a2be"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
