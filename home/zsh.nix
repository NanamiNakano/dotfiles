{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    fzf
  ];

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    presets = [
      "bracketed-segments"
      "nerd-font-symbols"
    ];
    settings = {
      aws.disabled = true;
      gcloud.disabled = true;
      username = {
        format = "[$user]($style) on ";
        style_user = "bold #8be9fd";
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = false;

    sessionVariables = {
      # LS color, defined esp. for cd color, 'cause exa has its own setting
      CLICOLOR = 1;
      LSCOLORS = "ExGxFxdaCxDaDahbadeche";

      HOMEBREW_NO_ANALYTICS = true;
      HOMEBREW_NO_ENV_HINTS = true;

      SSH_AUTH_SOCK = "/Users/nanami/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";

      EDITOR = "code --wait";
    };

    shellAliases = {
      lx = "eza -a --icons -G -l";
      la = "eza -a -G";
      darwin-build = "darwin-rebuild build --flake ~/dotfiles#default";
      darwin-switch = "sudo darwin-rebuild switch --flake ~/dotfiles#default";
      darwin-update = "nix flake update --flake ~/dotfiles";
    };

    initContent =
      with lib;
      mkMerge [
        (mkOrder 500 ''
          zstyle ':plugin:ez-compinit' 'use-cache' 'yes'

          zstyle ':completion:*' list-colors "''${(@s.:.)LS_COLORS}"
          zstyle ':completion:*:matches' group 'yes'
          zstyle ':completion:*:options' description 'yes'
          zstyle ':completion:*:options' auto-description '%d'
          zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
          zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
          zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
          zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
          zstyle ':completion:*:default' list-prompt '%S%M matches%s'
          zstyle ':completion:*' format '[%d]'
          zstyle ':completion:*' group-name ""
          zstyle ':completion:*' verbose yes
          zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
          zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
          zstyle ':completion:*' use-cache true
          zstyle ':completion:*' rehash true
          zstyle ':completion:*' menu select

          zstyle ":history-search-multi-word" page-size "11"
        '')
        # Key Bindings

        # \e, \E = Escape
        # ^[     = Alt / Option
        # ^X, ^  = Control
        # ^?     = Delete
        (mkOrder 1000 ''
          # Option + Left
          bindkey "^[[1;9D" backward-word
          bindkey "^[b"     backward-word
          # Option + Right
          bindkey "^[[1;9C" forward-word
          bindkey "^[f"     forward-word
        '')
      ];

    antidote.enable = true;
    antidote.plugins = [
      "mattmc3/ez-compinit"
      "romkatv/zsh-defer"
      "ohmyzsh/ohmyzsh path:lib/git.zsh"
      "ohmyzsh/ohmyzsh path:lib/functions.zsh"
      "ohmyzsh/ohmyzsh path:lib/directories.zsh"

      "zsh-users/zsh-completions path:src kind:fpath"
      "z-shell/ZUI path:functions kind:fpath"
      "Aloxaf/fzf-tab"

      "zsh-users/zsh-autosuggestions kind:defer"
      "nix-community/nix-zsh-completions kind:defer"
      "z-shell/ZUI kind:defer"
      "z-shell/F-Sy-H kind:defer"
      "z-shell/zzcomplete kind:defer"
      "z-shell/zsh-navigation-tools kind:defer"

      "ohmyzsh/ohmyzsh path:plugins/git/git.plugin.zsh kind:defer"
      "ohmyzsh/ohmyzsh path:plugins/macos/macos.plugin.zsh kind:defer"
      "ohmyzsh/ohmyzsh path:plugins/vscode/vscode.plugin.zsh kind:defer"
      "ohmyzsh/ohmyzsh path:plugins/sudo/sudo.plugin.zsh kind:defer"
      "ohmyzsh/ohmyzsh path:plugins/brew/brew.plugin.zsh kind:defer"
      "ohmyzsh/ohmyzsh path:plugins/extract/extract.plugin.zsh kind:defer"
      "MichaelAquilina/zsh-autoswitch-virtualenv kind:defer"
      "sunlei/zsh-ssh kind:defer"
    ];
  };
}
