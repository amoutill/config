{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nix-darwin, home-manager, nixpkgs, ... }@inputs: {
    darwinConfigurations = { 
      "Axels-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs; };
        modules = [ 
          ./hosts/Axels-MacBook-Pro/configuration.nix
          home-manager.darwinModules.home-manager
        ];
      };
    };
  };
}
