{ pkgs, ... }:

{
  home.username = "nanami";
  home.homeDirectory = "/Users/nanami";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    nixd
    nixfmt-rs
    ripgrep
    eza
  ];
  
  programs.home-manager.enable = true;

  imports = [
    ./zsh.nix
    ./ssh.nix
    ./git.nix
  ];
}
