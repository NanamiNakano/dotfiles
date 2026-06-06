{
  homebrew = {
    enable = true;
    enableZshIntegration = true;
    global.autoUpdate = false;
  };

  homebrew.casks = [
    # pre-install apps
    "iterm2"
    "secretive"
    "google-chrome"
    "jetbrains-toolbox"
    "telegram"
    "discord"
    "zoom"
    "1password"
    "squirrel-app"
    "openinterminal"

    # quick look extensions
    "syntax-highlight"
    "quicklook-video"
  ];
}
