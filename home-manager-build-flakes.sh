#!/bin/bash

## Taken from:
## https://www.reddit.com/r/NixOS/comments/iogoox/homemanager_with_flakes_on_non_nixos_system/


# build
nix --experimental-features 'flakes nix-command' build  .#macbook --verbose

# activate
#./result/activate
