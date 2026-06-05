{
  homebrew = {
    enable = true;
    enableZshIntegration = true;
    global.autoUpdate = false;
  };

  # pre-install apps
  homebrew.casks = [
    "iterm2"
    "secretive"
    "google-chrome"
    "jetbrains-toolbox"
    "telegram"
    "discord"
    "zoom"
    "1password"
  ];
}
