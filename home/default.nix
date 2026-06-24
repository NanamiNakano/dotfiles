{ pkgs, username, ... }:

{
  home.username = username;
  home.homeDirectory = "/Users/${username}";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    nil
    ripgrep
    eza
    helix
    just
    bat
    texlive.combined.scheme-full
  ];

  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  imports = [
    ./zsh.nix
    ./ssh.nix
    ./git.nix
  ];
}
