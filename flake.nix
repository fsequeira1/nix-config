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
        ];
      };

      wasp = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs user outputs;};
        modules = [
          {environment.systemPackages = [alejandra.defaultPackage.${system}];}
          ./hosts/wasp/configuration.nix
        ];
      };

      hornet = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs user outputs;};
        modules = [
          {environment.systemPackages = [alejandra.defaultPackage.${system}];}
          ./hosts/hornet/configuration.nix
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      # FIXME replace with your username@hostname
      "${user}@bumblebee" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system}; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit unstable user system inputs outputs;};
        # > Our main home-manager configuration file <
        modules = [./modules/home-manager/home.nix];
      };

      "${user}@wasp" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system}; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit unstable user system inputs outputs;};
        # > Our main home-manager configuration file <
        modules = [./modules/home-manager/home.nix];
      };

      "${user}@hornet" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system}; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit unstable user system inputs outputs;};
        # > Our main home-manager configuration file <
        modules = [./modules/home-manager/home.nix];
      };
    };
  };
}
