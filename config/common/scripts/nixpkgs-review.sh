#!/usr/bin/env bash

cd ~/Documents/projects/nix/nixpkgs-master/ || exit 1

GITHUB_TOKEN=$(pass-show-password "api.github.com/DamienCassou^nixpkgs-review")
export GITHUB_TOKEN

options="pr $@ --post-result"
exec nix-shell -p nixpkgs-review --run "nixpkgs-review $options"
