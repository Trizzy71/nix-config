{
  description = "Trizzy's nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {

    # Mac — standalone home-manager
    homeConfigurations."tristan@macbook" = home-manager.lib.homeManagerConfiguration {
      pkgs    = nixpkgs.legacyPackages."aarch64-darwin";
      modules = [ ./hosts/macbook/home.nix ];
    };

    # Arch — standalone home-manager on Linux
    homeConfigurations."tristan@arch" = home-manager.lib.homeManagerConfiguration {
      pkgs    = nixpkgs.legacyPackages."x86_64-linux";
      modules = [ ./hosts/arch/home.nix ];
    };

#    # Dell — NixOS
#    nixosConfigurations."dell" = nixpkgs.lib.nixosSystem {
#      system  = "x86_64-linux";
#      modules = [
#        ./hosts/dell/configuration.nix
#        home-manager.nixosModules.home-manager
#        {
#          home-manager.useGlobalPkgs    = true;
#          home-manager.useUserPackages  = true;
#          home-manager.users.tristan    = import ./hosts/dell/home.nix;
#        }
#      ];
#    };

  };
}
