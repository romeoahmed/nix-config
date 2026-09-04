{ pkgs, ... }:
{
  home = {
    stateVersion = "26.11";

    packages = [
      pkgs.azure-cli
      pkgs.hyperfine
      pkgs.tea
      pkgs.tokei
      pkgs.wget2
    ];
  };

  catppuccin = {
    enable = true;
    autoEnable = false;
    flavor = "macchiato";

    bat.enable = true;
    delta.enable = true;
    eza.enable = true;
    fish.enable = true;
    helix.enable = true;
    starship.enable = true;
  };

  programs = {
    fish.enable = true;

    starship.enable = true;

    git = {
      enable = true;
      settings = {
        user = {
          name = "Romeo Ahmed";
          email = "ahmedorqwn@gmail.com";
        };
        init.defaultBranch = "main";
      };
      signing = {
        format = "openpgp";
        key = "3281D557095847F9323E1ED48C5095EF11EA485A";
      };
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
    };

    gpg.enable = true;

    gh.enable = true;

    helix.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    nh.enable = true;

    bat.enable = true;
    eza.enable = true;
    fd.enable = true;
    ripgrep.enable = true;
    fastfetch.enable = true;

    # Fish enables this cache by default, but Darwin has no man package here.
    man.generateCaches = false;
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    sshKeys = [ "CCC243C1A35F6C658D0FBD78A853F5837B1C8678" ];
    pinentry.package = pkgs.pinentry_mac;
  };
}
