# Vagrant with QEMU configuration
{ config, pkgs, lib, user, ... }:

{
  # Enable virtualization services
  virtualisation = {
    # Enable libvirtd for QEMU/KVM
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = false;
        swtpm.enable = true;
      };
    };
    
    # Enable spice USB redirection
    spiceUSBRedirection.enable = true;
  };

  # Install required packages
  environment.systemPackages = with pkgs; [
    # Vagrant
    vagrant
    
    # QEMU and virtualization tools
    qemu_kvm
    qemu
    libvirt
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    virtio-win
    win-spice
  ];

  # Add user to required groups for virtualization
  users.users."${user}" = {
    extraGroups = [ "libvirtd" "kvm" ];
  };

  # Enable dconf for virt-manager GUI settings
  programs.dconf.enable = true;

  # Network configuration for libvirt
  #networking.firewall.checkReversePath = false;
  networking.firewall.trustedInterfaces = [ "virbr0" ];

  # Services configuration
  services = {
    # Enable SPICE vdagent for better VM integration
    spice-vdagentd.enable = true;
    
    # Enable USB redirection service
    udev.extraRules = ''
      # USB redirection for SPICE
      SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", GROUP="libvirtd", MODE="0664"
    '';
  };

  # Boot configuration for virtualization
  boot = {
    # Enable KVM nested virtualization (if supported)
    extraModprobeConfig = ''
      # Enable nested virtualization for Intel
      options kvm_intel nested=1
      
      # Enable nested virtualization for AMD  
      options kvm_amd nested=1
    '';
    
    # Load required kernel modules
    kernelModules = [ "kvm-intel" "kvm-amd" "vfio-pci" ];
    
    # Boot parameters for virtualization
    kernelParams = [
      # Enable IOMMU for hardware passthrough (optional)
      "intel_iommu=on"
      "amd_iommu=on"
    ];
  };

  # Environment variables for Vagrant
  environment.sessionVariables = {
    VAGRANT_DEFAULT_PROVIDER = "libvirt";
    LIBVIRT_DEFAULT_URI = "qemu:///system";
  };
}
