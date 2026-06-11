{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    alejandra.url = "github:kamadorueda/alejandra";
    alejandra.inputs.nixpkgs.follows = "nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = {
    self,
    alejandra,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nix-vscode-extensions,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    unstable = import nixpkgs-unstable {
      system = "x86_64-linux";
      config = {allowUnfree = true;};
    };
    user = "fsequeira";
    inherit (self) outputs;
    mkHost = hostname: 
     nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs user outputs hostname;};
        modules = [
          {environment.systemPackages = [alejandra.defaultPackage.${system}];}
          ./hosts/${hostname}/hardware-configuration.nix
          ./hosts/common/configuration.nix
          ./modules/nixos/gnome.nix
          ./modules/nixos/laptop.nix
          ./modules/nixos/docker.nix
          ./modules/nixos/security.nix
        
        {
        networking.hostName = hostname;
        system.autoUpgrade = {
          enable = true;
          dates = "daily";
          flake = "github:fsequeira1/nix-config#${hostname}";
          flags = [
            "--update-input"
            "nixpkgs"
            "--no-write-lock-file"
            "-L"
          ];
        };
      }

        home-manager.nixosModules.home-manager
        {
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "hm-backup";
          home-manager.extraSpecialArgs = {inherit unstable user system inputs outputs;};
          home-manager.users.${user} = import ./modules/home-manager/home.nix;
        }
      ];
    };

    in {
      nixosConfigurations = {
        bumblebee = mkHost "bumblebee";
        wasp = mkHost "wasp";
    };
  };
}
