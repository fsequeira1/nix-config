{
  lib,
  config,
  pkgs,
  unstable,
  user,
  system,
  inputs,
  ...
}: let
  gdk = pkgs.google-cloud-sdk.withExtraComponents (with pkgs.google-cloud-sdk.components; [
    gke-gcloud-auth-plugin
  ]);
  extensions =inputs.nix-vscode-extensions.extensions.${system};
in {
  imports = [
    (import (builtins.fetchurl {
      url = "https://gist.githubusercontent.com/piousdeer/b29c272eaeba398b864da6abf6cb5daa/raw/41e569ba110eb6ebbb463a6b1f5d9fe4f9e82375/mutability.nix";
      sha256 = "4b5ca670c1ac865927e98ac5bf5c131eca46cc20abf0bd0612db955bfc979de8";
    }) {inherit config lib;})
  ];

  nixpkgs = {
    overlays = [];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    unstable.gnome-network-displays
    unstable.firefox
    ghostty
    #vscode
    foliate
    zoom-us
    spotify
    discord
    slack
    neovim
    htop
    git
    vlc
    remmina
    waydroid
    vscode-fhs

    #shell
    oh-my-zsh
    atuin

    coreutils # GNU Utilities
    nix-tree # Browse Nix Store

    # neofetch
    ranger # terminal file manager

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processer https://github.com/mikefarah/yq
    # eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils # `dig` + `nslookup`
    #ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses

    # misc
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    direnv
    koreader

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor
    nil

    # productivity
    glow # markdown previewer in terminal

    btop # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
    powertop
    lshw
    antigravity-fhs

    #gaming
    steam-tui
    steamcmd

    #work
    k9s
    kind
    gdk
    kubectl
    awscli2
    flyctl
    packer
    ansible
    python3
    bat
    unstable.terraform
    unstable.go
    unstable.delve
    unstable.gopls
    unstable.go-tools
    unstable.chromium
    lmstudio
    lazydocker
  ];

  # Enable home-manager, git and zsh
  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      settings = {
        core.editor = "nvim";
        pull.rebase = true;
        init.defaultBranch = "main";
        url."ssh://git@".pushInsteadOf = "https://";
        user = {
          name = "Filipe Sequeira";
          email = "fsequeira1@users.noreply.github.com";
        };
      };
    };
    atuin = {
      enable = true;
      enableZshIntegration = true;
    };
    zellij = {
      enable = true;
    };
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
        ];
        theme = "robbyrussell";
      };
    };
  };


  programs.vscodium = {
    enable = true;
    package = unstable.vscodium;

    mutableExtensionsDir = false;

    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      extensions = with extensions.open-vsx;
        [
          # https://raw.githubusercontent.com/nix-community/nix-vscode-extensions/master/data/cache/open-vsx-latest.json

          # Essentials
          mikestead.dotenv
          #editorconfig.editorconfig

          # Interface Improvements
          eamodio.gitlens
          usernamehw.errorlens
          #pflannery.vscode-versionlens
          #gruntfuggly.todo-tree
          zhuangtongfa.material-theme

          #  # Nix
          jnoortheen.nix-ide
          #jetpack-io.devbox
          arrterian.nix-env-selector
          pinage404.nix-extension-pack

          # Testing
          #mtxr.sqltools
          #mtxr.sqltools-driver-pg

          # work
          ipedrazas.kubernetes-snippets
          golang.go
          ms-python.python
          esbenp.prettier-vscode
        ]
        ++ (with extensions.vscode-marketplace; [
          # https://raw.githubusercontent.com/nix-community/nix-vscode-extensions/master/data/cache/vscode-marketplace-latest.json
          amodio.toggle-excluded-files
          ettoreciprian.vscode-websearch
        ]);

      userSettings = {
        "disable-hardware-acceleration" = true;
        "window.titleBarStyle" = "custom";
        "window.zoomLevel" = 1;
        "editor.mouseWheelZoom" = true;
        "workbench.colorTheme" = "One Dark Pro Flat";
        "editor.fontFamily" = "'Fira Code', 'Droid Sans Mono', 'monospace', monospace";
        "editor.inlineSuggest.enabled" = true;
        "files.autoSave" = "afterDelay";

        "git.autofetch" = true;
        "git.confirmSync" = false;
        "git.enableCommitSigning" = true;

        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[json].editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[javascript].editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[typescript].editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[typescriptreact].editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[jsonc].editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[markdown].editor.defaultFormatter" = "esbenp.prettier-vscode";

        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "nix.formatterPath" = "nixpkgs-fmt";

        "errorLens.gutterIconsEnabled" = true;
        "errorLens.messageMaxChars" = 0;
      };
    };
  };

  # TODO move to gnome module
  dconf.settings = {
    # ...
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "codium.desktop"
        "com.mitchellh.ghostty.desktop"
        "org.gnome.Nautilus.desktop"
        "spotify.desktop"
      ];
    };
    "org/gnome/gnome-session" = {
      auto-save-session = true;
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;

      # `gnome-extensions list` for a list
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "trayIconsReloaded@selfmade.pl"
        "Vitals@CoreCoding.com"
        "dash-to-panel@jderose9.github.com"
        "caffeine@patapon.info"
        "quick-settings-audio-panel@rayzeq.github.io"
        #"blur-my-shell@aunetx"
      ];
    };
    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      workspaces-only-on-primary = true;
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enabled = true;
      speed = 0.23735408560311289;
      tap-to-click = true;
    };
    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Super><Shift>q"];
      show-desktop = ["<Super>d"];
    };
    "org/gnome/desktop/peripherals/mouse" = {
      natural-scroll = true;
      speed = -0.5;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      home = ["<Super>e"];
      next = ["<Super><Shift>n"];
      previous = ["<Super><Shift>p"];
      play = ["<Super><Shift>space"];
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        #"/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        #"/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
        #"/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Terminal";
      command = "ghostty";
      binding = "<Control><Alt>t";
    };

    "org/gnome/shell/extensions/dash-to-panel" = {
      appicon-margin = 0;
      panel-positions = builtins.toJSON {
        "0" = "TOP";
      };
      panel-sizes = builtins.toJSON {
        "0" = 32;
      };
    };

    #"org/gnome/desktop/background" = {
    #  picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/vnc-l.png";
    #  picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/vnc-d.png";
    #};
  };

  services = {
    home-manager.autoUpgrade = {
      enable = true;
      frequency = "daily";
    };
  };

  #Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "26.05";
}
