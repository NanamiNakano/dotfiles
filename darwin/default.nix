{ self, username, lib, pkgs, ... }:

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
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };
  system.primaryUser = username;

  system.defaults.finder = {
    AppleShowAllExtensions = true;
    ShowPathbar = true;
    ShowStatusBar = true;
    # prefer list view
    FXPreferredViewStyle = "Nlsv";
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  imports = [
    ./homebrew.nix
  ];
}
