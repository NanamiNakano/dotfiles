{ pkgs, username, ... }:

{
  home.username = username;
  home.homeDirectory = "/Users/${username}";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    nil
    nixd
    rust-analyzer
    lldb
    ripgrep
    eza
    helix
    just
    bat
    texlive.combined.scheme-full
    ocproxy
    gpoc
    xcodes
    opencode
  ];

  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  imports = [
    ./zsh.nix
    ./ssh.nix
    ./git.nix
  ];
}
