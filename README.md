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
