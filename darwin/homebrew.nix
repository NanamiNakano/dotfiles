{
  homebrew = {
    enable = true;
    enableZshIntegration = true;
    global.autoUpdate = false;
    onActivation.cleanup = "zap";
  };

  homebrew.brews = [
    "nanaminakano/gpoc/globalprotect-openconnect"
    "openconnect"
    "ocproxy"
    "xcodes"
  ];

  homebrew.casks = [
    "iterm2"
    "secretive"
    "zen"
    "jetbrains-toolbox"
    "telegram"
    "discord"
    "zoom"
    "1password"
    "squirrel-app"
    "snipaste"
    "calibre"
    "visual-studio-code"
    "openinterminal-lite"

    # quick look extensions
    "syntax-highlight"
    "quicklook-video"
  ];
}
