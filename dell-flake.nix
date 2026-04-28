{
  description = "Tristan's NixOS configuration";

  inputs = {
    # the main package source, same as your mac
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # home-manager for user config
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {

    nixosConfigurations."nixos-test" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";   # dell is x86, mac was aarch64-darwin
      modules = [
        ./configuration.nix       # your existing system config

        # wire home-manager in as a NixOS module
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;    # use the same nixpkgs as the system
          home-manager.useUserPackages = true;  # install user packages into user profile
          home-manager.users.tristan = import ./home.nix;  # your user config
        }
      ];
    };
  };
}
