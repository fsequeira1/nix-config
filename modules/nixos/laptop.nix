# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{...}: {
  services = {
    # laptop configs
    thermald.enable = true;
    #powerManagement.powertop.enable = true;

    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "balanced";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };
  };
}
