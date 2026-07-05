{ pkgs, username, ... }:

{
  home.username = username;
  home.homeDirectory = "/Users/${username}";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    ripgrep
    eza
    helix
    just
    bat
    ocproxy
    gpoc
    opencode
  ];

  programs.home-manager.enable = true;

  imports = [
    ./zsh.nix
    ./ssh.nix
    ./git.nix
    ./dev.nix
  ];
}
