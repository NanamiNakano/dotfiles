{ pkgs, username, ... }:

{
  home.username = username;
  home.homeDirectory = "/Users/${username}";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    nixd
    nixfmt-rs
    ripgrep
    eza
    helix
  ];
  
  programs.home-manager.enable = true;

  imports = [
    ./zsh.nix
    ./ssh.nix
    ./git.nix
  ];
}
