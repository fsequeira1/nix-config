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
- remove garbage on programs.vscode.extensions
- fix mutabilitty issues with vscode settings.json
    https://github.com/nix-community/home-manager/issues/1800
- split some parts into different modules
- add hyprland and multiple hosts
https://discourse.nixos.org/t/howto-disable-most-gnome-default-applications-and-what-they-are/13505
https://github.com/MatthiasBenaets/nixos-config/blob/master/modules/desktops/gnome.nix 

- tests: 
    - format computer and reinstall everything
    - upgrade distro 
```
