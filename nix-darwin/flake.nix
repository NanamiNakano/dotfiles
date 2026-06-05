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
      configuration =
        { lib, pkgs, ... }:
        {
          nixpkgs.hostPlatform = "aarch64-darwin";
          nixpkgs.config.allowUnfree = true;

          nix.package = pkgs.lix;
          nix.settings = {
            experimental-features = [
              "nix-command"
              "flakes"
            ];
            always-allow-substitutes = true;
            extra-trusted-substituters = [
              "https://cache.lix.systems"
            ];
            extra-trusted-public-keys = [
              "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
            ];
            bash-prompt-prefix = "(nix:$name)\\040";
            max-jobs = "auto";
            nix-path = [
              "nixpkgs=flake:nixpkgs"
            ];
          };

          programs.zsh.enable = true;

          environment.profiles = lib.mkForce [
            "/run/current-system/sw"
            "$HOME/.nix-profile"
            "/etc/profiles/per-user/$USER"
          ];
          environment.systemPackages = with pkgs; [
            helix
          ];
          fonts.packages = with pkgs; [
            nerd-fonts.jetbrains-mono
          ];

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 6;

          users.users.nanami = {
            name = "nanami";
            home = "/Users/nanami";
          };
          system.primaryUser = "nanami";

          security.pam.services.sudo_local.touchIdAuth = true;

          imports = [
            ./homebrew.nix
          ];
        };

      homeConfiguration = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.users.nanami = ./home.nix;
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Nanamis-Big-MacBook-Pro
      darwinConfigurations."Nanamis-Big-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          home-manager.darwinModules.home-manager
          homeConfiguration
        ];
      };
    };
}
