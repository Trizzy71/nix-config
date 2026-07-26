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
          /etc/nixos/hardware-configuration.nix
          ./modules/base-system.nix
          ./modules/user-tristan.nix
          ./modules/exit-node.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.tristan = import ./hosts/dell/home.nix;
          }
        ];
      };

      # frank-test - NixOS
      nixosConfigurations."frank-test" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/frank-test/configuration.nix
          ./hosts/frank-test/hardware-configuration.nix
          ./modules/base-system.nix
          ./modules/user-tristan.nix
          ./modules/exit-node.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.tristan = import ./hosts/frank-test/home.nix;
          }
        ];
      };

      # sdi-test - NixOS
      nixosConfigurations."2-test" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/2-test/configuration.nix
          ./hosts/2-test/hardware-configuration.nix
          ./modules/base-system.nix
          ./modules/user-tristan.nix
          ./modules/exit-node.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.tristan = import ./hosts/2-test/home.nix;
          }
        ];
      };

      # tristan — gaming desktop (NVIDIA 4070 Ti S)
      nixosConfigurations."tristan" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/tristan/configuration.nix
          ./hosts/tristan/hardware-configuration.nix
          ./modules/base-system.nix
          ./modules/user-tristan.nix
          ./modules/desktop-plasma.nix
          ./modules/gpu-nvidia.nix
          ./modules/gaming.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.tristan = import ./hosts/tristan/home.nix;
          }
        ];
      };

      # taryn — gaming desktop (AMD RX 480)
      nixosConfigurations."taryn" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/taryn/configuration.nix
          ./hosts/taryn/hardware-configuration.nix
          ./modules/base-system.nix
          ./modules/user-taryn.nix
          ./modules/desktop-plasma.nix
          ./modules/gpu-amd.nix
          ./modules/gaming.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.taryn = import ./hosts/taryn/home.nix;
          }
        ];
      };
    };
}
