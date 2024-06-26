{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    alejandra,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    unstable = import nixpkgs-unstable {
      system = "x86_64-linux";
      config = {allowUnfree = true;};
    };
    # FIXME replace with your username
    # (this will be propagated) to home-manager
    user = "fsequeira";
    inherit (self) outputs;
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # FIXME replace with your hostname
      bumblebee = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs user outputs;};
        modules = [
          {environment.systemPackages = [alejandra.defaultPackage.${system}];}
          ./hosts/bumblebee/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-backup";
            home-manager.extraSpecialArgs = {inherit unstable user system inputs outputs;};
            home-manager.users.${user} = import ./modules/home-manager/home.nix;
          }
        ];
      };

      wasp = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs user outputs;};
        modules = [
          {environment.systemPackages = [alejandra.defaultPackage.${system}];}
          ./hosts/wasp/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = {inherit unstable user system inputs outputs;};
            home-manager.users.${user} = import ./modules/home-manager/home.nix;
          }
        ];
      };

      hornet = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs user outputs;};
        modules = [
          {environment.systemPackages = [alejandra.defaultPackage.${system}];}
          ./hosts/hornet/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = {inherit unstable user system inputs outputs;};
            home-manager.users.${user} = import ./modules/home-manager/home.nix;
          }
        ];
      };
    };
  };
}
