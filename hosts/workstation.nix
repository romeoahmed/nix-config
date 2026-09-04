{
  inputs,
  pkgs,
  system,
  ...
}:
let
  username = "victor";
in
{
  imports = [
    inputs.determinate.darwinModules.default
    inputs.home-manager.darwinModules.home-manager
    inputs.nix-homebrew.darwinModules.nix-homebrew
    ../modules/darwin/homebrew.nix
    ../modules/darwin/workstation.nix
  ];

  nixpkgs.hostPlatform = system;

  system = {
    primaryUser = username;
    stateVersion = 7;
  };

  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.fish;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username}.imports = [
      inputs.catppuccin.homeModules.catppuccin
      ../modules/home/workstation.nix
    ];
  };
}
