#!/usr/bin/env bash

cd ~/personal/projects/nix/nixpkgs/ || exit 1

GITHUB_TOKEN=$(pass-show-password "api.github.com/DamienCassou^nixpkgs-review")
export GITHUB_TOKEN

options="pr $@ --post-result"
@nixpkgs-review@ $options
