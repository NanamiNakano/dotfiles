{ pkgs, ... }:

{
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
    xcodes
  ];

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
    globalConfig = {
      tools = {
        node = "lts";
      };
    };
  };

  programs.uv = {
    enable = true;
  };
}
