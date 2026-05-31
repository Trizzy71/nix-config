{
  description = "Trizzy's nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    {

      # Mac — standalone home-manager
      homeConfigurations."macbook" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."aarch64-darwin";
        modules = [
          ./hosts/macbook/home.nix
        ];
      };

      # Arch — standalone home-manager on Linux
      homeConfigurations."arch" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [
          ./hosts/arch/home.nix
        ];
      };

      # Dell — NixOS
      nixosConfigurations."dell" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/dell/configuration.nix
          /etc/nixos/hardware-configuration.nix # this links to the default path for hardware-configuration.nix
          ./modules/tailscale-system.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.tristan = import ./hosts/dell/home.nix;
          }
        ];
      };

      # work-test - NixOS
      nixosConfigurations."frank-test" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/frank-test/configuration.nix # MUST be changed to the work-test/configuration.nix
          /etc/nixos/hardware-configuration.nix # this links to the default path for hardware-configuration.nix
          ./modules/tailscale-system.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.tristan = import ./hosts/frank-test/home.nix;
          }
        ];
      };
    };
}
