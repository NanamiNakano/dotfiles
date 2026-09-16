{
  description = "nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    extra = {
      url = "path:./extra";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      home-manager,
      nixpkgs,
      nixpkgs-unstable,
      extra,
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
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-rs;
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#default
      darwinConfigurations.default = nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit
            self
            username
            inputs
            ;
        };

        modules = [
          {
            nixpkgs.overlays = [
              extra.overlays.default

              (final: prev: {
                unstable = import nixpkgs-unstable {
                  system = final.stdenv.hostPlatform.system;
                };
              })
            ];
          }
          darwinConfiguration
          home-manager.darwinModules.home-manager
          homeConfiguration
        ];
      };
    };
}
