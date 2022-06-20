#!/bin/bash

ulimit -S -n 2048  # Temporarily increase the number of file descriptors

## Taken from:
## https://www.reddit.com/r/NixOS/comments/iogoox/homemanager_with_flakes_on_non_nixos_system/

# build
nix --verbose --experimental-features 'flakes nix-command' build ".#homeManagerConfigurations.gpampara.activationPackage" "$@"

# activate
#./result/activate
