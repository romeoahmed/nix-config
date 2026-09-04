{ inputs, ... }:
{
  imports = [
    inputs.git-hooks-nix.flakeModule
    inputs.treefmt-nix.flakeModule
  ];

  perSystem =
    { config, pkgs, ... }:
    {
      treefmt = {
        projectRootFile = "flake.nix";
        programs.nixfmt.enable = true;
      };

      pre-commit.settings.hooks = {
        deadnix.enable = true;
        statix.enable = true;
        treefmt.enable = true;
      };

      devShells.default = pkgs.mkShellNoCC {
        packages = [
          pkgs.just
          pkgs.nixd
        ]
        ++ config.pre-commit.settings.enabledPackages;

        shellHook = config.pre-commit.shellHook;
      };
    };
}
