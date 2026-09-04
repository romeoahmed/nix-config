# nix-config

[![CI](https://github.com/romeoahmed/nix-config/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/romeoahmed/nix-config/actions/workflows/ci.yml)

A flake-first configuration for one Apple Silicon Mac, built with
[flake-parts](https://flake.parts/),
[nix-darwin](https://github.com/nix-darwin/nix-darwin), and
[Home Manager](https://github.com/nix-community/home-manager) on nixpkgs
unstable.

The repository treats macOS, Homebrew, command-line tools, and dotfiles as one
declarative system. Language toolchains stay in project-specific development
shells instead of the global workstation profile.

## What it manages

- Determinate Nix through its nix-darwin module, with the nix-community binary
  cache enabled.
- Homebrew itself through [nix-homebrew](https://github.com/zhaofengli/nix-homebrew)
  and Homebrew packages through nix-darwin.
- Fish, Git, GnuPG, Helix, direnv, nh, and other user tools through Home
  Manager.
- A selective Catppuccin Macchiato theme for supported terminal applications.
- Formatting, linting, evaluation, and system builds through the flake
  development shell and GitHub Actions.

Homebrew is limited to the `container` and `mole` formulae plus these casks:
ChatGPT, Ghostty, IINA, Keka, OnyX, SFM, and Visual Studio Code. The Apple
container service starts automatically.

## Requirements

- An Apple Silicon Mac running macOS 26.
- Administrator access for the initial system activation.
- [Determinate Nix](https://docs.determinate.systems/determinate-nix/).

## Install

Clone the repository into any directory:

```console
git clone https://github.com/romeoahmed/nix-config.git
cd nix-config
```

Before applying it to another account, review:

- `hosts/workstation.nix` for the macOS account name.
- `modules/home/workstation.nix` for the Git identity, OpenPGP signing
  fingerprint, and GPG agent SSH keygrip.
- `modules/darwin/homebrew.nix` for the applications that will be installed.

Remove an existing unmanaged Homebrew installation before the first
activation. Automatic migration is deliberately disabled.

> [!CAUTION]
> Homebrew activation uses `cleanup = "zap"`. Undeclared formulae, casks, and
> files associated with removed casks may be deleted.

Install nix-darwin and activate the `workstation` configuration from the
repository root:

```console
sudo nix run nix-darwin/master#darwin-rebuild -- \
  switch --flake .#workstation
```

## Use

Apply later changes with nh:

```console
nh darwin switch . -H workstation
```

Enter the repository development shell to access its maintenance tools:

```console
nix develop
just --list
```

| Command       | Purpose                                      |
| ------------- | -------------------------------------------- |
| `just fmt`    | Format Nix files                             |
| `just hooks`  | Run all formatting and static-analysis hooks |
| `just check`  | Run every flake check                        |
| `just eval`   | Evaluate the Darwin system derivation        |
| `just build`  | Build the system without activating it       |
| `just switch` | Build and activate the system with nh        |

## Structure

| Path                    | Purpose                                            |
| ----------------------- | -------------------------------------------------- |
| `flake.nix`             | Inputs, supported platform, and output composition |
| `hosts/workstation.nix` | Account binding and host assembly                  |
| `modules/darwin/`       | Machine, Nix, and Homebrew policy                  |
| `modules/home/`         | User packages, programs, and dotfiles              |
| `modules/flake/`        | Formatter, checks, and development shell           |
| `.github/`              | Continuous integration and dependency updates      |

## License

[MIT](LICENSE) © 2026 Romeo Ahmed
