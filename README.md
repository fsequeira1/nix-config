# nix-config

## Apply system configuration
```bash
sudo nixos-rebuild switch --flake .#bumblebee
```

## Apply your home configuration
```bash
home-manager switch --flake .#fsequeira@bumblebee

# on first run might need this
nix build .#homeConfigurations.fsequeira@bumblebee.activationPackage && ./result/activate
```

## Update flake.lock
```bash
nix flake update
```

## Or replace only the specific input, such as home-manager:
```bash
nix flake lock --update-input home-manager
```

## debug config
```bash
sudo nixos-rebuild switch --flake .#bumblebee --show-trace -L
```


# TODO 
```
- split some parts into different modules
https://github.com/Misterio77/nix-config/tree/main/home/misterio/features/desktop/common/wayland-wm
    - modules/desktop/{gnome.nix, hyprland.nix}
    - hosts/{bumblebee, wasp, hornet, common}/{configuration.nix, hardware-configuration.nix}
    - shells/{python, go, java, js}
    - work    

- gnome shortcuts/ keybindings

- tests: 
    - format computer and reinstall everything
    - upgrade distro 
```
