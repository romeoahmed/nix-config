set shell := ["bash", "-euo", "pipefail", "-c"]

default:
  @just --list

fmt:
  nix fmt

hooks:
  nix develop --command pre-commit run --all-files

check:
  nix flake check

eval:
  nix eval --show-trace .#darwinConfigurations.workstation.system.drvPath

build:
  darwin-rebuild build --flake .#workstation

switch:
  nh darwin switch . -H workstation
