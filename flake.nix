{
  description = "trizzy 71 nix config";

  # where packages and tools come from - exact versions are pinned in flake.lock
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05"; # stable release branch
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable"; # for the few packages that need to move faster, e.g. claude-code
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05"; # matches the nixpkgs release
      inputs.nixpkgs.follows = "nixpkgs"; # use the same nixpkgs as the system - saves storage, avoids version conflicts
    };
  };

  # the machines this repo builds - each host's configuration.nix lists everything on it
  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    {
      nixosConfigurations = {
        jensen = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; }; # lets modules reach flake inputs
          modules = [ ./hosts/jensen/configuration.nix ];
        };

        lisa = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/lisa/configuration.nix ];
        };

        qtile-node = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/qtile-node/configuration.nix ];
        };
      };

      # mac - home-manager on its own, no NixOS underneath
      homeConfigurations.macbook = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          config.allowUnfree = true;
        };
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./hosts/macbook/home.nix ];
      };

      # `nix fmt` formats every .nix file in the repo
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
    };
}
