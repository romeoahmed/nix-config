{ config, ... }:
{
  nix-homebrew = {
    enable = true;
    user = config.system.primaryUser;
    autoMigrate = false;
    mutableTaps = false;

    # nix-darwin owns the only shell integration below.
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableZshIntegration = false;
  };

  homebrew = {
    enable = true;
    enableFishIntegration = true;

    global.autoUpdate = false;

    onActivation.cleanup = "zap";

    brews = [
      {
        name = "container";
        start_service = true;
      }
      "mole"
    ];

    casks = [
      "chatgpt"
      "ghostty"
      "iina"
      "keka"
      "onyx"
      "sfm"
      "visual-studio-code"
    ];
  };
}
