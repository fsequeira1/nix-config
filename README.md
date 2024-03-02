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


# TODO install zed
# TODO try nvidia offload config try reduce wattage
# TODO configure gnome shortcuts and extensions, and remove packages
# split some parts into different modules
https://discourse.nixos.org/t/howto-disable-most-gnome-default-applications-and-what-they-are/13505
https://github.com/MatthiasBenaets/nixos-config/blob/master/modules/desktops/gnome.nix 