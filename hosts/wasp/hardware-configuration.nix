# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  systemd.network.wait-online.enable = false;

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
  systemd.services.systemd-networkd-wait-online.enable = lib.mkForce false;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = [];
    kernelModules = ["kvm-intel"];
    initrd = {
      kernelModules = [];
      availableKernelModules = ["xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
      verbose = false;
      systemd.network.wait-online.enable = false;
    };
    plymouth = {
      enable = true;
      theme = "lone";
      themePackages = [(pkgs.adi1090x-plymouth-themes.override {selected_themes = ["lone"];})];
    };
    loader.timeout = 0;
    kernelParams = [
      "quiet"
      "loglevel=3"
      "systemd.show_status=auto"
      "udev.log_level=3"
      "rd.udev.log_level=3"
      "vt.global_cursor_default=0"
    ];
    consoleLogLevel = 0;
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/c38eeda2-cef9-4798-a08a-f1b45ca381b2";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-9ec92217-4394-454f-8c2d-595a63dc93c7".device = "/dev/disk/by-uuid/9ec92217-4394-454f-8c2d-595a63dc93c7";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/A2EC-82CB";
    fsType = "vfat";
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware = {
    cpu = {
      intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
    graphics = {
      enable = true;
      extraPackages = with pkgs; [intel-media-driver];
      enable32Bit = true;
    };
  };
}
