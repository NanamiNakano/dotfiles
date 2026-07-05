{ pkgs, username, ... }:

{
  home.username = username;
  home.homeDirectory = "/Users/${username}";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    # Language servers
    nil
    nixd
    tombi

    # Developing environments
    rustup
    texlive.combined.scheme-full
    lldb
    pnpm

    ripgrep
    eza
    helix
    just
    bat
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
    config = {
      global = {
        hide_env_diff = true;
      };
    };
  };

  programs.mise = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.uv = {
    enable = true;
  };

  imports = [
    ./zsh.nix
    ./ssh.nix
    ./git.nix
  ];
}
