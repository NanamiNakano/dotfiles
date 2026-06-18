{
  description = "nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      home-manager,
      ...
    }:
    let
      username = "nanami";

      darwinConfiguration = ./darwin;
      homeConfiguration = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit username inputs; };
        home-manager.users.${username} = ./home;
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Nanamis-Big-MacBook-Pro
      darwinConfigurations."Nanamis-Big-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit self username inputs;
        };

        modules = [
          darwinConfiguration
          home-manager.darwinModules.home-manager
          homeConfiguration
        ];
      };
    };
}
