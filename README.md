# nix-config

## Apply system configuration

```bash
sudo nixos-rebuild switch --flake .#$(hostname)
```
or

```bash
sudo nixos-rebuild switch --flake .#bumblebee
```

## Apply your home configuration

```bash
home-manager switch --flake .#$(whoami)@$(hostname)
```
or

```bash
home-manager switch --flake .#fsequeira@bumblebee

# on first run might need to add git to the packages on /etc/nixos/configuration.nix
# and then the commands bellow, after that you can use home-
nix-shell -p git
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

## No such file or directory (when restructuring flake)
```bash
sudo nix-store --repair --verify --check-contents
```


# TODO 
```
- https://github.com/Misterio77/nix-config/blob/main/hosts/common/optional/quietboot.nix
- gnome shortcuts/ keybindings create hashmap with bindings, use similar in gnome and hyprland
- modules/{hyprland.nix}
- https://github.com/fufexan/dotfiles/blob/main/system/core/security.nix

[org/gnome/desktop/peripherals/touchpad]
two-finger-scrolling-enabled=true

[org/gnome/desktop/wm/keybindings]
close=['<Shift><Super>q']

[org/gnome/settings-daemon/plugins/media-keys]
home=['<Super>e']



/org/gnome/shell/extensions/dash-to-panel/panel-sizes
  '{"0":32}'

/org/gnome/shell/extensions/dash-to-panel/appicon-margin
  4


/org/gnome/shell/extensions/dash-to-panel/panel-positions
  '{"0":"TOP"}'


/org/gnome/desktop/peripherals/mouse/natural-scroll
  true

/org/gnome/settings-daemon/plugins/media-keys/home
  ['<Super>e']

/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/binding
  '<Control><Alt>t'
/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/command
  'gnome-terminal'
/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/name
  'Terminal'

/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings
  ['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']

/org/gnome/desktop/peripherals/touchpad/two-finger-scrolling-enabled
  true


/org/gnome/desktop/peripherals/mouse/natural-scroll
  true

/org/gnome/desktop/peripherals/touchpad/tap-to-click
  true

/org/gnome/desktop/peripherals/touchpad/speed
  0.23735408560311289

/org/gnome/shell/extensions/dash-to-panel/panel-positions
  '{"0":"TOP"}'

/org/gnome/shell/extensions/dash-to-panel/panel-sizes
  '{"0":32}'

/org/gnome/shell/extensions/dash-to-panel/appicon-margin
  0



## ONLY to desktop
/org/gnome/settings-daemon/plugins/power/sleep-inactive-ac-type
  'nothing'

```
