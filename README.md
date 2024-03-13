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

## No such file or directory
```bash
sudo nix-store --repair --verify --check-contents
```


# TODO 
```
    - add github action to validate everything
    - configure desktop from scratch, format, uefi, encrypt disk
    - gnome shortcuts/ keybindings create hashmap with bindings, use similar in gnome and hyprland
    - modules/{hyprland.nix}

- tests: 
    - format computer and reinstall everything
    - upgrade distro 
```
